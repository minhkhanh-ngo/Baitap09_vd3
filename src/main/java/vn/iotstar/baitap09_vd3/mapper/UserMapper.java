package vn.iotstar.baitap09_vd3.mapper;

import org.mapstruct.*;
import vn.iotstar.baitap09_vd3.dto.UserDTO;
import vn.iotstar.baitap09_vd3.entity.User;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper {
    @Mapping(target = "roleName", source = "role.name")
    UserDTO toDTO(User entity);

    @Mapping(target = "role", ignore = true)
    @Mapping(target = "products", ignore = true)
    @Mapping(target = "password", ignore = true)
    User toEntity(UserDTO dto);
}