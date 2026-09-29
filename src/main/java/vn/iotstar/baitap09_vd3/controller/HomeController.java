package vn.iotstar.baitap09_vd3.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.iotstar.baitap09_vd3.service.ProductService;
import vn.iotstar.baitap09_vd3.service.UserService;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final UserService userService;
    private final ProductService productService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("userCount", userService.countUsers());
        model.addAttribute("productCount", productService.countProducts());
        return "home";
    }
}