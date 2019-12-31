package com.kzq.advance.service.impl;

import com.kzq.advance.common.utils.files.FileUploadUtils;
import com.kzq.advance.domain.TSRBill;
import com.kzq.advance.domain.TSRBillDetail;
import com.kzq.advance.domain.TSRBillFile;
import com.kzq.advance.domain.TUser;
import com.kzq.advance.mapper.TSRBillDetailMapper;
import com.kzq.advance.mapper.TSRBillFileMapper;
import com.kzq.advance.mapper.TSRBillMapper;
import com.kzq.advance.mapper.TUserMapper;
import com.kzq.advance.service.ISRBillService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

@Service
public class SRBillServiceImpl implements ISRBillService {

    @Resource
    private TSRBillMapper tsrBillMapper;

    @Resource
    private TSRBillDetailMapper tsrBillDetailMapper;

    @Resource
    private TSRBillFileMapper tsrBillFileMapper;

    @Resource
    private TUserMapper userMapper;

    @Override
    public List<TSRBill> find(TSRBill tsrBill) {
        return tsrBillMapper.find(tsrBill);
    }

    @Override
    public TSRBill findTsrDetail(TSRBill searchTsrBill) {
        TSRBill tsrBill = tsrBillMapper.findDetail(searchTsrBill);
        if (StringUtils.isNotBlank(tsrBill.getBizUserId())) {
            TUser user = userMapper.findUserByUserId(tsrBill.getBizUserId());
            if (user != null) tsrBill.setBizUserName(user.getName());
        }
        return tsrBill;
    }

    @Override
    public List<TSRBillDetail> findDetDetail(TSRBillDetail tsrBillDetail) {
        return tsrBillDetailMapper.findDetDetail(tsrBillDetail);
    }

    @Value("${wxUploadPath}")
    private String uploadPath;

    @Override
    public Boolean save(TSRBill tsrBill, HttpServletRequest request) throws IOException {
        boolean flag = false;
        if (null != tsrBill.getTsrBillDetail() && tsrBill.getTsrBillDetail().size() > 0) {
            for (TSRBillDetail tsrBillDetail : tsrBill.getTsrBillDetail()) {
                //保存详情表
                //一定要判断非空，不然会sql 报错
                if (StringUtils.isNotBlank(tsrBillDetail.getStatus()) && !tsrBillDetail.getStatus().equals("0")) {
                    flag = tsrBillDetailMapper.updateByPrimaryKeySelective(tsrBillDetail) > 0;
                }
            }
        }
        boolean fileflag = insertFile(tsrBill);
        boolean srbillflag = false;
        if (StringUtils.isNotBlank(tsrBill.getMemo()))
            srbillflag = tsrBillMapper.updateByPrimaryKeySelective(tsrBill) > 0;
        tsrBill.setBizdt(new Date());
        if (request.getSession().getAttribute("user") != null)
            tsrBill.setBizUserId(((TUser) request.getSession().getAttribute("user")).getId());
        if (flag || fileflag || srbillflag)
            return true;
        else
            return false;
    }

    private boolean insertFile(TSRBill tsrBill) throws IOException {
        String fileBasePath = uploadPath;
        //保存视频和图片
        boolean flag1 = false;
        boolean flag2 = false;
        if (tsrBill.getImages() != null && tsrBill.getImages().size() > 0) {
            flag1 = insertImgFile(tsrBill, fileBasePath);
        }
        if (tsrBill.getVdos() != null && tsrBill.getVdos().size() > 0) {
            flag2 = insertVdoFile(tsrBill, fileBasePath);
        }
        if (flag1 || flag2)
            return true;
        else
            return false;
    }

    private void insertUser(TSRBill tsrBill, HttpServletRequest request) {
        HttpSession session = request.getSession();
        TUser user = (TUser) session.getAttribute("user");
        if (user != null && user.getId() != null) {
            tsrBill.setBizUserId(user.getId());
            tsrBill.setInputUserId(user.getId());
        }
        if (session.getAttribute("warehouseId") != null) {
            tsrBill.setWarehouseId((String) session.getAttribute("warehouseId"));
        }
    }

    @Override
    public Boolean addSrBill(TSRBill tsrBill, HttpServletRequest request) throws IOException {
        boolean flag = false;

        String memo = "";
        tsrBill.setBillStatus(0);
        tsrBill.setMaintainSale((byte) 2);
        String ref = genNewBillRef();
        tsrBill.setRef(ref);
        tsrBill.setType(1);
        tsrBill.setBizdt(new Date());
        tsrBill.setDateCreated(new Date());

        UUID uuid = UUID.randomUUID();
        tsrBill.setId(uuid.toString());
        insertUser(tsrBill, request);
        for (TSRBillDetail tsrBillDetail : tsrBill.getTsrBillDetail()) {
            memo = memo + tsrBillDetail.getGoodsName() + "*" + tsrBillDetail.getGoodsCount() + ":" + tsrBillDetail.getStatus() + "; ";
        }
        tsrBill.setMemo(memo);

        insertFile(tsrBill);
        //</editor-fold>

        //保存主表
        flag = tsrBillMapper.insertSelective(tsrBill) > 0;
        //新建一个退货单
        return flag;
    }

    private boolean insertVdoFile(TSRBill tsrBill, String fileBasePath) throws IOException {
        int count = 0;
        for (MultipartFile vdo : tsrBill.getVdos()) {
            if (null != vdo && StringUtils.isNotBlank(vdo.getOriginalFilename())) {
                String vdoPath = FileUploadUtils.upload(fileBasePath, vdo);
                count += insertFile(vdo.getOriginalFilename(), tsrBill.getId(), vdoPath, 2);
            }
        }
        return count > 0;
    }

    private boolean insertImgFile(TSRBill tsrBill, String fileBasePath) throws IOException {
        int count = 0;
        for (MultipartFile image : tsrBill.getImages()) {
            if (null != image && StringUtils.isNotBlank(image.getOriginalFilename())) {
                String imgPath = FileUploadUtils.upload(fileBasePath, image);
                count += insertFile(image.getOriginalFilename(), tsrBill.getId(), imgPath, 1);
            }
        }
        return count > 0;
    }

    //生成一个退货单号
    public String genNewBillRef() {

        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddmmss");//设置日期格式
        String ref = df.format(new Date());
        Random random = new Random();
        String result = "";
        for (int i = 0; i < 3; i++) {
            result += random.nextInt(10);

        }
        ref = "WX" + ref + result;
        return ref;


    }

    @Override
    public List<TSRBillFile> findImages(String id) {
        TSRBillFile tsrBillFile = new TSRBillFile();
        tsrBillFile.setSrdetailId(id);
        tsrBillFile.setFileType(1);
        return tsrBillFileMapper.find(tsrBillFile);
    }

    @Override
    public List<TSRBillFile> findVdo(String id) {
        TSRBillFile tsrBillFile = new TSRBillFile();
        tsrBillFile.setSrdetailId(id);
        tsrBillFile.setFileType(2);
        return tsrBillFileMapper.find(tsrBillFile);
    }

    @Override
    public int delImg(Long imgId) {
        return tsrBillFileMapper.deleteByPrimaryKey(imgId);
    }

    private int insertFile(String fileName, String srDetailId, String imgPath, int i) {
        TSRBillFile file = new TSRBillFile();
        file.setFileName(fileName);
        file.setFilePath(imgPath);
        file.setFileType(i);
        file.setSrdetailId(srDetailId);
        return tsrBillFileMapper.insert(file);
    }

}
