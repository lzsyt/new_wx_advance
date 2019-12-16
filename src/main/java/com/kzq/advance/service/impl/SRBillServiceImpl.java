package com.kzq.advance.service.impl;

import com.kzq.advance.common.utils.files.FileUploadUtils;
import com.kzq.advance.domain.TSRBill;
import com.kzq.advance.domain.TSRBillDetail;
import com.kzq.advance.domain.TSRBillFile;
import com.kzq.advance.domain.TUser;
import com.kzq.advance.mapper.TSRBillDetailMapper;
import com.kzq.advance.mapper.TSRBillFileMapper;
import com.kzq.advance.mapper.TSRBillMapper;
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

    @Override
    public List<TSRBill> find(TSRBill tsrBill) {
        return tsrBillMapper.find(tsrBill);
    }

    @Override
    public TSRBill findTsrDetail(TSRBill searchTsrBill) {
        return tsrBillMapper.findDetail(searchTsrBill);
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
        //记录处理的商品
        int num=0;
        for (TSRBillDetail tsrBillDetail : tsrBill.getTsrBillDetail()) {
            //保存详情表
            //一定要判断非空，不然会sql 报错
            if (tsrBillDetail.getStatus() != null&&StringUtils.isNotBlank(tsrBillDetail.getStatus())) {
                flag = tsrBillDetailMapper.updateByPrimaryKeySelective(tsrBillDetail) > 0;
                num++;

            }
        }
        String fileBasePath =uploadPath;
        //保存视频和图片
        if (tsrBill.getImages()!=null){

            for (MultipartFile image : tsrBill.getImages()) {
                if (StringUtils.isNotBlank(image.getOriginalFilename())){

                    String imgPath = FileUploadUtils.upload(fileBasePath, image);
                    insertFile(image.getOriginalFilename(), tsrBill.getId(), imgPath, 1);}
            }
        }
        if (tsrBill.getVdos()!=null){

        for (MultipartFile vdo : tsrBill.getVdos()) {
            if (StringUtils.isNotBlank(vdo.getOriginalFilename())){
                String vdoPath = FileUploadUtils.upload(fileBasePath, vdo);
            insertFile(vdo.getOriginalFilename(), tsrBill.getId(), vdoPath, 2);}
        }}
        //处理状态   0：未处理 1：部分处理，2：全部处理
      List<TSRBillDetail> billdetail= tsrBill.getTsrBillDetail();
        if (billdetail!=null&&num!=0){
            //只有一个商品的情况
            if(num==billdetail.size()){
                //已处理
                tsrBill.setBillStatus(2);

            }else if(num<billdetail.size()){
                //部分处理
                tsrBill.setBillStatus(1);
            }
            //更新主表处理状态
            tsrBillMapper.updateByPrimaryKeySelective(tsrBill);

        }

        return true;
    }
    @Override
    public Boolean addSrBill(TSRBill tsrBill, HttpServletRequest request) throws IOException {
        boolean flag = false;
        HttpSession session=request.getSession();
        String memo="";
        tsrBill.setBillStatus(2);
        String ref=genNewBillRef();
        tsrBill.setRef(ref);
        tsrBill.setType(1);
        tsrBill.setBizdt(new Date());
        tsrBill.setDateCreated(new Date());

        UUID uuid = UUID.randomUUID();
        tsrBill.setId(uuid.toString());
        TUser user= (TUser) session.getAttribute("user");
        if (user!=null &&user.getId()!=null){

            tsrBill.setBizUserId(user.getId());
            tsrBill.setInputUserId(user.getId());
        }

        for (TSRBillDetail tsrBillDetail : tsrBill.getTsrBillDetail()) {
            memo=memo+tsrBillDetail.getGoodsName()+"*"+tsrBillDetail.getGoodsCount()+":"+tsrBillDetail.getStatus()+"; ";
        }
        tsrBill.setMemo(memo);


        String fileBasePath = uploadPath;

        if(tsrBill.getImages()!=null&&tsrBill.getImages().size()>0){
            for (MultipartFile image : tsrBill.getImages()) {
               if (StringUtils.isNotBlank(image.getOriginalFilename())){
                   String imgPath = FileUploadUtils.upload(fileBasePath, image);
                   insertFile(image.getOriginalFilename(), tsrBill.getId(), imgPath, 1);
               }

            }

        }
        //保存视频和图片
        if(tsrBill.getVdos()!=null&&tsrBill.getVdos().size()>0){
        for (MultipartFile vdo : tsrBill.getVdos()) {
            if (StringUtils.isNotBlank(vdo.getOriginalFilename())){
                String vdoPath = FileUploadUtils.upload(fileBasePath, vdo);
                insertFile(vdo.getOriginalFilename(), tsrBill.getId(), vdoPath, 2);}
        }}
        //保存主表
        tsrBill.setBillStatus(2);
        tsrBillMapper.insertSelective(tsrBill);
        //新建一个退货单
        return flag;
    }
    //生成一个退货单号
   public String  genNewBillRef(){

       SimpleDateFormat df = new SimpleDateFormat("yyyyMMddmmss");//设置日期格式
       String ref=df.format(new Date());
       Random random=new Random();
       String result="";
      for(int i=0;i<3;i++){
      result+=random.nextInt(10);

      }
       ref="WX"+ref+result;
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

    public boolean isPart(String srBillId) {
        TSRBillDetail tsrBillDetail = new TSRBillDetail();
        tsrBillDetail.setSrbillId(srBillId);
        List<TSRBillDetail> tsrBillDetails = tsrBillDetailMapper.findDetDetail(tsrBillDetail);
        int cout = 0;
        for (TSRBillDetail billDetail : tsrBillDetails) {
            if (billDetail.getStatus() != null&&StringUtils.isNotBlank(billDetail.getStatus())) {
                cout++;
            }
        }
        if (cout == tsrBillDetails.size()) {
            return false;
        }
        return true;

    }

    private void insertFile(String fileName, String srDetailId, String imgPath, int i) {
        TSRBillFile file = new TSRBillFile();
        file.setFileName(fileName);
        file.setFilePath(imgPath);
        file.setFileType(i);
        file.setSrdetailId(srDetailId);
        tsrBillFileMapper.insert(file);
    }

}