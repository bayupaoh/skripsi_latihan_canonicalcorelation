-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 14 Mei 2017 pada 18.25
-- Versi Server: 10.1.19-MariaDB
-- PHP Version: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `analisis_korelasi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dataset`
--

CREATE TABLE `dataset` (
  `tanggal` date NOT NULL,
  `suhu` double NOT NULL,
  `kelembapan` double NOT NULL,
  `amonia` double NOT NULL,
  `kematian` int(11) NOT NULL,
  `ip` double NOT NULL,
  `hargaJual` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

create table result(
	  id int primary key auto_increment,
    pertanyaan text not null,
    hasil text not null.
	koefisien double not null
)engine=innoDB;

insert into result values(null,1,"hasil mantap",0)

--
-- Dumping data untuk tabel `dataset`
--

INSERT INTO `dataset` (`tanggal`, `suhu`, `kelembapan`, `amonia`, `kematian`, `ip`, `hargaJual`) VALUES
('2016-12-26', 20, 68, 11, 16, 270, 11626),
('2016-12-27', 24, 64, 9, 15, 273, 11824),
('2016-12-28', 0, 0, 0, 9, 274, 11870),
('2016-12-29', 21, 65, 10, 15, 275, 11982),
('2016-12-30', 26, 66, 8, 7, 277, 12099),
('2016-12-31', 25, 62, 14, 7, 279, 12128),
('2017-01-01', 23, 68, 14, 13, 281, 12244),
('2017-01-02', 22, 63, 12, 13, 283, 12423),
('2017-01-03', 25, 63, 14, 18, 285, 12657),
('2017-01-04', 21, 71, 13, 11, 287, 13065),
('2017-01-05', 21, 70, 13, 9, 290, 13182),
('2017-01-06', 23, 71, 13, 15, 292, 14998),
('2017-01-07', 30, 70, 9, 15, 292, 13928),
('2017-01-08', 20, 61, 8, 14, 294, 13220),
('2017-01-09', 22, 67, 12, 15, 299, 13298),
('2017-01-10', 26, 68, 9, 8, 301, 13495),
('2017-01-11', 21, 60, 15, 7, 303, 13529),
('2017-01-12', 24, 68, 12, 15, 310, 13752),
('2017-01-13', 24, 65, 15, 15, 314, 13823),
('2017-01-14', 23, 72, 13, 16, 319, 14123),
('2017-01-15', 26, 69, 14, 7, 320, 14526);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
