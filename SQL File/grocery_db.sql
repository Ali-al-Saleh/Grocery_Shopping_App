-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2025 at 10:04 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grocery_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cid` decimal(8,0) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cid`, `name`) VALUES
(1, 'Fruits'),
(2, 'Vegetables'),
(3, 'Dairy'),
(4, 'Beverages'),
(5, 'Snacks');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `pid` decimal(8,0) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `cid` decimal(8,0) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`pid`, `name`, `quantity`, `price`, `cid`, `image_url`) VALUES
(101, 'Apples', 50, 1.50, 1, 'http://localhost/grocery_app/images/apples.png'),
(102, 'Bananas', 60, 0.99, 1, 'http://localhost/grocery_app/images/bananas.png'),
(103, 'Oranges', 40, 1.20, 1, 'http://localhost/grocery_app/images/oranges.png'),
(104, 'Tomatoes', 80, 2.00, 2, 'http://localhost/grocery_app/images/tomatoes.png'),
(105, 'Potatoes', 100, 1.00, 2, 'http://localhost/grocery_app/images/potatoes.png'),
(106, 'Onions', 70, 1.50, 2, 'http://localhost/grocery_app/images/onions.png'),
(107, 'Milk', 90, 3.00, 3, 'http://localhost/grocery_app/images/milk.png'),
(108, 'Cheese', 60, 4.50, 3, 'http://localhost/grocery_app/images/cheese.png'),
(109, 'Yogurt', 30, 2.20, 3, 'http://localhost/grocery_app/images/yogurt.png'),
(110, 'Juice', 100, 2.99, 4, 'http://localhost/grocery_app/images/juice.png'),
(111, 'Soda', 120, 1.25, 4, 'http://localhost/grocery_app/images/soda.png'),
(112, 'Water', 200, 0.80, 4, 'http://localhost/grocery_app/images/water.png'),
(113, 'Chips', 150, 1.99, 5, 'http://localhost/grocery_app/images/chips.png'),
(114, 'Cookies', 130, 2.50, 5, 'http://localhost/grocery_app/images/cookies.png'),
(115, 'Chocolate', 110, 1.75, 5, 'http://localhost/grocery_app/images/chocolate.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `cid` (`cid`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `categories` (`cid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
