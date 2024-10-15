package io.github.butex.backend.service;

import io.github.butex.backend.dao.entity.RoleEntity;
import io.github.butex.backend.dao.entity.RoleType;
import io.github.butex.backend.dao.repository.RoleRepository;
import io.github.butex.backend.exception.DataNotFoundException;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service
public class RoleService {

    @Autowired
    private RoleRepository roleRepository;

    @PostConstruct
    public void checkIfRoles() {
        Arrays.stream(RoleType.values()).forEach(roleType -> {
            try {
                findRoleByRoleType(roleType);
            } catch (DataNotFoundException e) {
                createNewRole(roleType);
            }
        });
    }

    public RoleEntity findRoleByRoleType(final RoleType roleType) {
        return roleRepository.findByRoleName(roleType)
                .orElseThrow(() -> new DataNotFoundException("Role Not Found with role name: " + roleType.name()));
    }

    public RoleEntity createNewRole(RoleType role) {
        RoleEntity roleEntity = new RoleEntity();
        roleEntity.setRoleName(role);
        return roleRepository.save(roleEntity);
    }

}
