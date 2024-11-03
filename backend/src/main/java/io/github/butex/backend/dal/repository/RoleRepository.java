package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.Role;
import io.github.butex.backend.constant.RoleType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {

    Optional<Role> findByRoleName(RoleType roleName);

}
