-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2018 at 06:07 PM
-- Server version: 10.1.22-MariaDB
-- PHP Version: 7.0.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ussd_ghana`
--

-- --------------------------------------------------------

--
-- Table structure for table `checkout`
--

CREATE TABLE `checkout` (
  `id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `amount` double(10,2) UNSIGNED ZEROFILL NOT NULL,
  `reg_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer_account`
--

CREATE TABLE `customer_account` (
  `id` int(11) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `account_balance` double(10,2) NOT NULL,
  `loan_amount` double(10,2) NOT NULL,
  `reg_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_account`
--

INSERT INTO `customer_account` (`id`, `phoneNumber`, `account_balance`, `loan_amount`, `reg_date`) VALUES
(1, '+254728986084', 12450.00, 0.00, '2017-12-25 11:00:00'),
(2, '+254720234587', 2000.00, 0.00, '2017-12-25 04:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `customer_details`
--

CREATE TABLE `customer_details` (
  `id` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `id_number` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `validation` varchar(30) NOT NULL,
  `reg_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_details`
--

INSERT INTO `customer_details` (`id`, `firstname`, `surname`, `phoneNumber`, `id_number`, `city`, `validation`, `reg_date`) VALUES
(1, 'Basil', 'Ndonga', '+254728986084', '26514056', 'Nairobi', '', '2017-12-25 11:00:00'),
(2, 'Robert', 'Ouko', '+254720234587', '26514053', 'Kitale', '', '2017-12-25 11:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `message_logs`
--

CREATE TABLE `message_logs` (
  `id` int(11) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `message` varchar(1024) NOT NULL,
  `status` varchar(20) NOT NULL,
  `cost` double(5,2) UNSIGNED ZEROFILL NOT NULL,
  `reg_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `session_levels`
--

CREATE TABLE `session_levels` (
  `session_id` varchar(50) DEFAULT NULL,
  `phoneNumber` varchar(25) DEFAULT NULL,
  `level` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `session_levels`
--

INSERT INTO `session_levels` (`session_id`, `phoneNumber`, `level`) VALUES
('ATUid_6e4903b4552b2e2723e246669f8b6807', '+254728986084', 1),
('ATUid_6e4903b4552b2e2723e246669f8b6807', '+254728986084', 1),
('ATUid_6e4903b4552b2e2723e246669f8b6807', '+254728986084', 1),
('ATUid_6e4903b4552b2e2723e246669f8b6807', '+254728986084', 1),
('ATUid_9ac314744e1cbf9f2ef625afaf7efb22', '+254728986084', 10),
('ATUid_9ac314744e1cbf9f2ef625afaf7efb22', '+254728986084', 10),
('ATUid_97fd27427e5dd28f09ea5df034cd596a', '+254728986084', 1),
('ATUid_97fd27427e5dd28f09ea5df034cd596a', '+254728986084', 1),
('ATUid_45471858ae1846effff280ed4c370936', '+254728986084', 1),
('ATUid_45471858ae1846effff280ed4c370936', '+254728986084', 1),
('ATUid_4e92f2eb68f1fd2ac53a9c581210d1df', '+254728986084', 1),
('ATUid_4e92f2eb68f1fd2ac53a9c581210d1df', '+254728986084', 1),
('ATUid_4e92f2eb68f1fd2ac53a9c581210d1df', '+254728986084', 1),
('ATUid_4e92f2eb68f1fd2ac53a9c581210d1df', '+254728986084', 1),
('ATUid_26861563e01c4e21087ef293fe279563', '+254728986084', 1),
('ATUid_26861563e01c4e21087ef293fe279563', '+254728986084', 1),
('ATUid_4c05c6e7d19058ce29a54462fdfa4c96', '+254728986084', 9),
('ATUid_4c05c6e7d19058ce29a54462fdfa4c96', '+254728986084', 9),
('ATUid_98b41a4325c7a131a44943d966dd41ae', '+254728986084', 9),
('ATUid_98b41a4325c7a131a44943d966dd41ae', '+254728986084', 9),
('ATUid_801a9c540bbf74e5d08a4cb80763b396', '+254728986084', 9),
('ATUid_801a9c540bbf74e5d08a4cb80763b396', '+254728986084', 9),
('ATUid_61af99e6709b629b7a2ed39f4943eb07', '+254728986084', 9),
('ATUid_61af99e6709b629b7a2ed39f4943eb07', '+254728986084', 9),
('ATUid_61af99e6709b629b7a2ed39f4943eb07', '+254728986084', 9),
('ATUid_61af99e6709b629b7a2ed39f4943eb07', '+254728986084', 9),
('ATUid_d9c93600b92eba03ca297f20e452cd4a', '+254728986084', 9),
('ATUid_d9c93600b92eba03ca297f20e452cd4a', '+254728986084', 9),
('ATUid_dafb19b74a0475f212882535c26e5f67', '+254728986084', 1),
('ATUid_dafb19b74a0475f212882535c26e5f67', '+254728986084', 1),
('ATUid_e31a38fe5a289dc5af5a7788376f0f41', '+254728986084', 9),
('ATUid_e31a38fe5a289dc5af5a7788376f0f41', '+254728986084', 9),
('ATUid_8632c76bf134c0ed2bf827949d72dedc', '+254728986084', 9),
('ATUid_8632c76bf134c0ed2bf827949d72dedc', '+254728986084', 9),
('ATUid_114ec0ef2302f9262b6c0fc9653cbc2d', '+254728986084', 9),
('ATUid_114ec0ef2302f9262b6c0fc9653cbc2d', '+254728986084', 9),
('ATUid_314a68b23a2301a4ec23c5bb68a35050', '+254728986084', 9),
('ATUid_314a68b23a2301a4ec23c5bb68a35050', '+254728986084', 9),
('ATUid_314a68b23a2301a4ec23c5bb68a35050', '+254728986084', 9),
('ATUid_314a68b23a2301a4ec23c5bb68a35050', '+254728986084', 9),
('ATUid_3c7a0636adbe3ac5248aeba9c835c24b', '+254728986084', 9),
('ATUid_3c7a0636adbe3ac5248aeba9c835c24b', '+254728986084', 9),
('ATUid_b053ac8b4a998916b70c8b82d8d15804', '+254728986084', 9),
('ATUid_b053ac8b4a998916b70c8b82d8d15804', '+254728986084', 9),
('ATUid_1bfe50c12d05fa555519e555a67a7572', '+254728986084', 9),
('ATUid_1bfe50c12d05fa555519e555a67a7572', '+254728986084', 9),
('ATUid_ee8f3ae1ce13315e2558a2b248eff63c', '+254728986084', 9),
('ATUid_ee8f3ae1ce13315e2558a2b248eff63c', '+254728986084', 9),
('ATUid_289f4538825938cb6cb8e8bb879175eb', '+254728986084', 9),
('ATUid_289f4538825938cb6cb8e8bb879175eb', '+254728986084', 9),
('ATUid_cf3b155732077678c87c5a028dd95931', '+254728986084', 9),
('ATUid_cf3b155732077678c87c5a028dd95931', '+254728986084', 9),
('ATUid_f996a2e3bca175b963c212a7b414aa9b', '+254728986084', 1),
('ATUid_f996a2e3bca175b963c212a7b414aa9b', '+254728986084', 1),
('ATUid_42da882ab66ee6963e84220a8c2c68e6', '+254728986084', 1),
('ATUid_42da882ab66ee6963e84220a8c2c68e6', '+254728986084', 1),
('ATUid_42da882ab66ee6963e84220a8c2c68e6', '+254728986084', 1),
('ATUid_42da882ab66ee6963e84220a8c2c68e6', '+254728986084', 1),
('ATUid_a26e93a43dbc83f363d58d68e44a1f3c', '+254728986084', 1),
('ATUid_a26e93a43dbc83f363d58d68e44a1f3c', '+254728986084', 1),
('ATUid_d4e223d61697367b14fdfa7bf08b0ffd', '+254728986084', 1),
('ATUid_d4e223d61697367b14fdfa7bf08b0ffd', '+254728986084', 1),
('ATUid_3273d8c7a6611283c166a738079cd142', '+254728986084', 9),
('ATUid_3273d8c7a6611283c166a738079cd142', '+254728986084', 9),
('ATUid_578d2221aab8d6d74726092ff40997f9', '+254728986084', 1),
('ATUid_578d2221aab8d6d74726092ff40997f9', '+254728986084', 1),
('ATUid_0a7093e1239a4e0ef0176e4afdfb298c', '+254728986084', 1),
('ATUid_0a7093e1239a4e0ef0176e4afdfb298c', '+254728986084', 1),
('ATUid_c46d3c058dbbc7cb433013c4a6fb327d', '+254728986084', 10),
('ATUid_c46d3c058dbbc7cb433013c4a6fb327d', '+254728986084', 10),
('ATUid_4f92527868e14b6233c1c9dd8031ec63', '+254728986084', 9),
('ATUid_4f92527868e14b6233c1c9dd8031ec63', '+254728986084', 9),
('ATUid_4e53a259af1d285780476afc926b91d5', '+254728986084', 9),
('ATUid_4e53a259af1d285780476afc926b91d5', '+254728986084', 9),
('ATUid_03d892c36f8bbc7b9e09c96fda945678', '+254728986084', 9),
('ATUid_03d892c36f8bbc7b9e09c96fda945678', '+254728986084', 9),
('ATUid_10aeb31a402ff089e04ff6b50f4d23cb', '+254728986084', 9),
('ATUid_10aeb31a402ff089e04ff6b50f4d23cb', '+254728986084', 9),
('ATUid_a848c97216b87e810e1915ad8209d8be', '+254728986084', 9),
('ATUid_a848c97216b87e810e1915ad8209d8be', '+254728986084', 9),
('ATUid_4161eba3d68ddfc5d3d03ca0a273fd28', '+254728986084', 9),
('ATUid_4161eba3d68ddfc5d3d03ca0a273fd28', '+254728986084', 9),
('ATUid_054b6495344a63326a526faa2b722afa', '+254728986084', 9),
('ATUid_054b6495344a63326a526faa2b722afa', '+254728986084', 9),
('ATUid_7b859a0619a185b0b0c2694d1068ebbc', '+254728986084', 9),
('ATUid_7b859a0619a185b0b0c2694d1068ebbc', '+254728986084', 9),
('ATUid_7b2bbf709915d44fa91d62daa7d276fc', '+254728986084', 1),
('ATUid_7b2bbf709915d44fa91d62daa7d276fc', '+254728986084', 1),
('ATUid_b00e51120011520c5d9b9fef60786182', '+254728986084', 9),
('ATUid_b00e51120011520c5d9b9fef60786182', '+254728986084', 9),
('ATUid_e97fc64de9d2cb9fce9919519fef2efd', '+254728986084', 9),
('ATUid_e97fc64de9d2cb9fce9919519fef2efd', '+254728986084', 9),
('ATUid_40c105a18a3ae77e680b6ef22e7973a8', '+254728986084', 9),
('ATUid_40c105a18a3ae77e680b6ef22e7973a8', '+254728986084', 9),
('ATUid_df58933b55cbc4133d07fcf59ad724d6', '+254728986084', 9),
('ATUid_df58933b55cbc4133d07fcf59ad724d6', '+254728986084', 9),
('ATUid_6fc30983d4f8a350b8850f27976cbee5', '+254728986084', 9),
('ATUid_6fc30983d4f8a350b8850f27976cbee5', '+254728986084', 9),
('ATUid_8c36c1fc3e4a778865e29edaa6e5b300', '+254728986084', 9),
('ATUid_8c36c1fc3e4a778865e29edaa6e5b300', '+254728986084', 9),
('ATUid_5b88d73c125a84fb8959f38157f66711', '+254728986084', 9),
('ATUid_5b88d73c125a84fb8959f38157f66711', '+254728986084', 9),
('ATUid_75cb02623dddf49c1421b7965f93bfb5', '+254728986084', 9),
('ATUid_75cb02623dddf49c1421b7965f93bfb5', '+254728986084', 9),
('ATUid_68850146fdb1dadb250985f0c4ecf641', '+254728986084', 9),
('ATUid_68850146fdb1dadb250985f0c4ecf641', '+254728986084', 9),
('ATUid_b921d20b8a2d9759f97bab7638054c63', '+254728986084', 9),
('ATUid_b921d20b8a2d9759f97bab7638054c63', '+254728986084', 9),
('ATUid_11ddbd2e9a0e33e1eb5d2428597fd29c', '+254728986084', 10),
('ATUid_11ddbd2e9a0e33e1eb5d2428597fd29c', '+254728986084', 10),
('ATUid_ab09197e83ee5be65f1a0fedaae9edf5', '+254728986084', 9),
('ATUid_ab09197e83ee5be65f1a0fedaae9edf5', '+254728986084', 9),
('ATUid_ab09197e83ee5be65f1a0fedaae9edf5', '+254728986084', 9),
('ATUid_ab09197e83ee5be65f1a0fedaae9edf5', '+254728986084', 9),
('ATUid_242275cd3ac101b81918d687423f09d6', '+254728986084', 1),
('ATUid_242275cd3ac101b81918d687423f09d6', '+254728986084', 1),
('ATUid_e341625bafdaa6363902fb4d16e6f195', '+254728986084', 1),
('ATUid_e341625bafdaa6363902fb4d16e6f195', '+254728986084', 1),
('ATUid_d44296c36c9ba993b0f57b49e124528a', '+254728986084', 1),
('ATUid_d44296c36c9ba993b0f57b49e124528a', '+254728986084', 1),
('ATUid_0b94a55457f19154def48edc70c026b8', '+254728986084', 1),
('ATUid_0b94a55457f19154def48edc70c026b8', '+254728986084', 1),
('ATUid_0b94a55457f19154def48edc70c026b8', '+254728986084', 1),
('ATUid_0b94a55457f19154def48edc70c026b8', '+254728986084', 1),
('ATUid_e5bf2c979692577d6ab3809369306a9a', '+254728986084', 9),
('ATUid_e5bf2c979692577d6ab3809369306a9a', '+254728986084', 9),
('ATUid_333b80afb505da324085d670ba56eb18', '+254728986084', 9),
('ATUid_333b80afb505da324085d670ba56eb18', '+254728986084', 9),
('ATUid_333b80afb505da324085d670ba56eb18', '+254728986084', 9),
('ATUid_333b80afb505da324085d670ba56eb18', '+254728986084', 9),
('ATUid_f75e69875cd45b22d32a3aa85845fc4d', '+254728986084', 9),
('ATUid_f75e69875cd45b22d32a3aa85845fc4d', '+254728986084', 9),
('ATUid_f75e69875cd45b22d32a3aa85845fc4d', '+254728986084', 9),
('ATUid_f75e69875cd45b22d32a3aa85845fc4d', '+254728986084', 9);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_account`
--
ALTER TABLE `customer_account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_details`
--
ALTER TABLE `customer_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message_logs`
--
ALTER TABLE `message_logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `customer_account`
--
ALTER TABLE `customer_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `customer_details`
--
ALTER TABLE `customer_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `message_logs`
--
ALTER TABLE `message_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
