package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.RoleEntity;
import io.github.butex.backend.constant.RoleType;
import io.github.butex.backend.dal.repository.RoleRepository;
import io.github.butex.backend.exception.DataNotFoundException;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service
@RequiredArgsConstructor
public class RoleService {

    private final RoleRepository roleRepository;

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

    public void createNewRole(RoleType role) {
        RoleEntity roleEntity = new RoleEntity();
        roleEntity.setRoleName(role);
        roleRepository.save(roleEntity);
    }
}
