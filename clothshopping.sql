-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 13, 2020 at 01:32 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clothshopping`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `user_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(2),
(2),
(2),
(2),
(2),
(2),
(2),
(2);

-- --------------------------------------------------------

--
-- Table structure for table `order_main`
--

CREATE TABLE `order_main` (
  `order_id` bigint(20) NOT NULL,
  `buyer_address` varchar(255) DEFAULT NULL,
  `buyer_email` varchar(255) DEFAULT NULL,
  `buyer_name` varchar(255) DEFAULT NULL,
  `buyer_phone` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `order_amount` decimal(19,2) NOT NULL,
  `order_status` int(11) NOT NULL DEFAULT 0,
  `update_time` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `category_type` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`category_id`, `category_name`, `category_type`, `create_time`, `update_time`) VALUES
(2147483641, 'tshirt', 0, '2020-03-09 12:03:26', '2020-03-09 13:15:27'),
(2147483642, 'jeans', 1, '2020-07-09 12:03:26', '2020-07-09 13:15:27'),
(2147483643, 'shoes', 2, '2020-07-09 09:03:26', '2020-07-09 11:15:27');

-- --------------------------------------------------------

--
-- Table structure for table `product_info`
--

CREATE TABLE `product_info` (
  `product_id` varchar(255) NOT NULL,
  `category_type` int(11) DEFAULT 0,
  `create_time` timestamp NULL DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  `product_icon` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` decimal(19,2) NOT NULL,
  `product_status` int(11) DEFAULT 0,
  `product_stock` int(11) NOT NULL,
  `update_time` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_info`
--

INSERT INTO `product_info` (`product_id`, `category_type`, `create_time`, `product_description`, `product_icon`, `product_name`, `product_price`, `product_status`, `product_stock`, `update_time`) VALUES
('B0009', 0, '2020-03-09 23:37:39', 'White T-Shirt', 'https://www.pexels.com/photo/991509/download/?search_query=tshirt&tracking_id=d9kphharphh', 'Adidas T-Shirt', '30.00', 1, 200, '2020-03-10 08:42:02'),
('B0003', 0, '2020-03-09 23:37:39', 't-shirt best', 'https://www.pexels.com/photo/2146756/download/?search_query=tshirt&tracking_id=d9kphharphh', 'Nike T-shirt', '20.00', 1, 200, '2020-03-10 08:42:02'),
('C0003', 0, '2020-03-10 01:12:46', 'Mans', 'https://img1.newchic.com/thumb/view/oaupload/newchic/images/00/30/df8a1f83-035c-4942-93d6-49933ac52a34.jpg', 'Coats', '22.00', 0, 222, '2020-03-10 01:12:46'),
('D0001', 0, '2020-03-09 19:51:03', 'Everyone likes it', 'https://www.pexels.com/photo/3775119/download/?search_query=tshirt%20girl&tracking_id=d9kphharphh', 'Yellow Tshirt', '10.00', 0, 100, '2020-03-10 01:04:13'),
('C0001', 0, '2020-03-10 01:09:41', 'Under Armour', 'https://assets.academy.com/mgen/33/20088533.jpg?is=500,500', 'T-shirt', '10.00', 0, 109, '2020-03-10 01:09:41'),
('E0003', 1, '2020-07-09 23:37:39', 'Blue Jeans', 'https://www.pexels.com/photo/52574/download/?search_query=jeans&tracking_id=d9kphharphh', 'Wrangler Jeans', '15.00', 0, 400, '2020-07-10 08:42:02'),
('E0007', 1, '2020-07-10 01:12:46', 'Mans', 'https://www.pexels.com/photo/1804075/download/?search_query=jeans&tracking_id=d9kphharphh', 'Jeans', '20.00', 0, 222, '2020-07-10 01:12:46'),
('F0001', 1, '2020-07-09 19:51:03', 'M-Jeans', 'https://www.pexels.com/photo/1235692/download/?search_query=jeans&tracking_id=d9kphharphh', 'Jean by M', '10.00', 0, 100, '2020-07-10 01:04:13'),
('F0002', 1, '2020-07-09 23:35:43', 'Funky Jeans', 'https://www.pexels.com/photo/936023/download/?search_query=jeans&tracking_id=d9kphharphh', 'Nappy Jeans', '25.00', 0, 195, '2020-07-09 23:35:43'),
('F0005', 1, '2020-07-10 01:09:41', 'Comfort Jacob Women Jeans', 'https://www.pexels.com/photo/1346187/download/?search_query=jeans&tracking_id=d9kphharphh', 'Jacob Jean', '12.00', 0, 109, '2020-07-10 01:09:41'),
('L0002', 1, '2020-07-10 01:11:51', 'Stretchable comfy jean', 'https://www.pexels.com/photo/1701199/download/?search_query=jeans&tracking_id=d9kphharphh', 'Comfy Jean', '17.00', 0, 108, '2020-07-10 01:11:51');

-- --------------------------------------------------------

--
-- Table structure for table `product_in_order`
--

CREATE TABLE `product_in_order` (
  `id` bigint(20) NOT NULL,
  `category_type` int(11) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `product_description` varchar(255) NOT NULL,
  `product_icon` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` decimal(19,2) NOT NULL,
  `product_stock` int(11) DEFAULT NULL,
  `cart_user_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `active`, `address`, `email`, `name`, `password`, `phone`, `role`) VALUES
(1, 1, 'Ram Bagh road', 'sanyamgoyal42@gmail.com', 'Sanyam Goyal', '$2a$10$weHjY7mdbSF8LVlPqHRSIee57jHEUucNUnaCQGothHa2.IJYC7O9.', '8219550861', 'ROLE_CUSTOMER');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `order_main`
--
ALTER TABLE `order_main`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `UK_6kq6iveuim6wd90cxo5bksumw` (`category_type`);

--
-- Indexes for table `product_info`
--
ALTER TABLE `product_info`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_in_order`
--
ALTER TABLE `product_in_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKhnivo3fl2qtco3ulm4mq0mbr5` (`cart_user_id`),
  ADD KEY `FKt0sfj3ffasrift1c4lv3ra85e` (`order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_sx468g52bpetvlad2j9y0lptc` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
