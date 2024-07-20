package com.project.shopapp.services;

import com.project.shopapp.dtos.OrderDetailDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Order;
import com.project.shopapp.models.OrderDetail;
import com.project.shopapp.models.Product;
import com.project.shopapp.repositories.OrderDetailRepository;
import com.project.shopapp.repositories.OrderRepository;
import com.project.shopapp.repositories.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderDetailService implements IOrderDetailService{

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    @Override
    public OrderDetail createOrderDetail(OrderDetailDTO orderDetailDTO) throws Exception {
        Order order = orderRepository.findById(orderDetailDTO.getOrderId()).orElseThrow(()->
                 new DataNotFoundException("Cannot find order with id :"+ orderDetailDTO.getOrderId()));
        Product product = productRepository.findById(orderDetailDTO.getProductId()).orElseThrow(()->
                new DataNotFoundException("Cannot find order with id :"+ orderDetailDTO.getOrderId()));
        OrderDetail orderDetail = OrderDetail.builder()
                .order(order)
                .product(product)
                .price((orderDetailDTO.getPrice()))
                .numberOfProducts(orderDetailDTO.getNumberOfProducts())
                .totalMoney(orderDetailDTO.getTotalMoney())
                .color(orderDetailDTO.getColor())
                .build();
        return orderDetailRepository.save(orderDetail);
    }

    @Override
    public OrderDetail getOrderDetail(Long id) throws DataNotFoundException {
        return orderDetailRepository.findById(id).orElseThrow(()->
                new DataNotFoundException("Cannot find Order detail with id: "+ id));
    }

    @Override
    public OrderDetail updateOrderDetail(Long id, OrderDetailDTO orderDetailDTO) throws DataNotFoundException {
        //tim xem orderdetail co ton tai hay khong
        OrderDetail existingOrderDetail = orderDetailRepository.findById(id).orElseThrow(()->
                        new DataNotFoundException("Can't find order detail with Id: "+ id));
        //order id co thuoc ve mot order nao do khong
        Order existingOrder = orderRepository.findById(orderDetailDTO.getOrderId()).orElseThrow(()->
                new DataNotFoundException("Can't find order Id: "+ id));
        //product co thuoc ve order nao do hay khong
        Product existingproduct = productRepository.findById(orderDetailDTO.getProductId()).orElseThrow(()->
                new DataNotFoundException("Cannot find order with id :"+ orderDetailDTO.getOrderId()));
        existingOrderDetail.setOrder(existingOrder);
        existingOrderDetail.setProduct(existingproduct);
        existingOrderDetail.setPrice(orderDetailDTO.getPrice());
        existingOrderDetail.setNumberOfProducts(orderDetailDTO.getNumberOfProducts());
        existingOrderDetail.setTotalMoney(orderDetailDTO.getTotalMoney());
        existingOrderDetail.setColor(orderDetailDTO.getColor());
        return orderDetailRepository.save(existingOrderDetail);
    }

    @Override
    public void deletOrder(Long id) {
        orderDetailRepository.deleteById(id);
    }

    @Override
    public List<OrderDetail> findByOrderId(Long orderId) {
        return orderDetailRepository.findByOrderId(orderId);
    }
}
