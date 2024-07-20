package com.project.shopapp.repositories;

import com.project.shopapp.models.Order;
import org.aspectj.weaver.ast.Or;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    //tim don hang cua 1 user bat ki
    List<Order> findByUserId(Long userId);
}
