package com.kzq.advance.mapper;


import com.kzq.advance.domain.TUser;
import com.kzq.advance.domain.vo.Warehouse;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author zmn
 * @since 2018-08-22
 */
@Mapper
public interface TUserMapper {


     String doLogin(String name);
     public void updateUserOpenId(TUser u);
     public TUser findUser(TUser tUser);
     public Warehouse findUserWarehouse(String userId);

     public List<String> findPermissionByUserId(String userId);

     public TUser findUserByUserId(String id);


}