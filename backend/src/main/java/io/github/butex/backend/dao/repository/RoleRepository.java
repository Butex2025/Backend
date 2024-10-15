package io.github.butex.backend.dao.repository;

import io.github.butex.backend.dao.entity.RoleEntity;
import io.github.butex.backend.dao.entity.RoleType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<RoleEntity, Integer> {

    Optional<RoleEntity> findByRoleName(RoleType roleName);

}