-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2020 at 08:40 AM
-- Server version: 5.5.32
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tokocat`
--
CREATE DATABASE IF NOT EXISTS `tokocat` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tokocat`;

-- --------------------------------------------------------

--
-- Table structure for table `cat`
--

CREATE TABLE IF NOT EXISTS `cat` (
  `kode_cat` varchar(8) NOT NULL,
  `nama_cat` varchar(30) NOT NULL,
  `kategori` varchar(30) NOT NULL,
  `warna` varchar(30) NOT NULL,
  `ukuran` varchar(6) NOT NULL,
  `harga_jual` int(11) NOT NULL,
  `jumlah_cat` int(11) NOT NULL,
  PRIMARY KEY (`kode_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cat`
--

INSERT INTO `cat` (`kode_cat`, `nama_cat`, `kategori`, `warna`, `ukuran`, `harga_jual`, `jumlah_cat`) VALUES
('C001', 'Nippon Paint', 'Cat Interior', 'Putih', '1kg', 25000, 6),
('K002', 'Avian', 'Cat Eksteriror', 'Coklat', '4kg', 50000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE IF NOT EXISTS `kategori` (
  `kode_kategori` varchar(6) NOT NULL,
  `kategori` varchar(30) NOT NULL,
  PRIMARY KEY (`kode_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`kode_kategori`, `kategori`) VALUES
('K001', 'Cat Interior'),
('K002', 'Cat Mobil'),
('K003', 'Cat Eksteriror');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_beli`
--

CREATE TABLE IF NOT EXISTS `tbl_beli` (
  `nofaktur` varchar(11) NOT NULL,
  `kode_cat` varchar(11) NOT NULL,
  `nama_cat` varchar(50) NOT NULL,
  `hsatuan` int(11) NOT NULL,
  `jumlah_beli` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `bayar` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_beli`
--

INSERT INTO `tbl_beli` (`nofaktur`, `kode_cat`, `nama_cat`, `hsatuan`, `jumlah_beli`, `harga`, `bayar`, `kembalian`, `tanggal`) VALUES
('F0001', 'C001', 'Nippon Paint', 25000, 2, 50000, 60000, 10000, '2020-04-18'),
('F0002', 'K002', 'Avian', 50000, 4, 200000, 300000, 50000, '2020-04-18'),
('F0002', 'C001', 'Nippon Paint', 25000, 2, 50000, 300000, 50000, '2020-04-18'),
('F0003', 'K002', 'Avian', 50000, 7, 350000, 600000, 50000, '2020-04-18'),
('F0003', 'C001', 'Nippon Paint', 25000, 2, 50000, 600000, 50000, '2020-04-18'),
('F0003', 'C001', 'Nippon Paint', 25000, 6, 150000, 600000, 50000, '2020-04-18');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tmp_beli`
--

CREATE TABLE IF NOT EXISTS `tbl_tmp_beli` (
  `id_tmp` int(11) NOT NULL AUTO_INCREMENT,
  `kode_cat` varchar(11) NOT NULL,
  `nama_cat` varchar(50) NOT NULL,
  `hsatuan` int(11) NOT NULL,
  `jumlah_beli` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  PRIMARY KEY (`id_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Triggers `tbl_tmp_beli`
--
DROP TRIGGER IF EXISTS `batal`;
DELIMITER //
CREATE TRIGGER `batal` AFTER DELETE ON `tbl_tmp_beli`
 FOR EACH ROW BEGIN
UPDATE cat SET jumlah_cat = jumlah_cat + OLD.jumlah_beli
WHERE kode_cat = OLD.kode_cat;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `beli`;
DELIMITER //
CREATE TRIGGER `beli` AFTER INSERT ON `tbl_tmp_beli`
 FOR EACH ROW BEGIN 
UPDATE cat SET jumlah_cat = jumlah_cat - new.jumlah_beli 
WHERE kode_cat = new.`kode_cat`; 
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `nama` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `level` varchar(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `password`, `level`) VALUES
(1, 'Admin Suramin', 'admin', 'admin', 'admin'),
(2, 'Danu', 'Rizal', 'saputro', 'admin'),
(4, 'Nobita', 'Shizuka', 'doraemon', 'admin'),
(5, 'Novika', 'anggraini', 'danu', 'admin');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
