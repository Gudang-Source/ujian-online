-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Jun 2020 pada 14.41
-- Versi server: 10.1.35-MariaDB
-- Versi PHP: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ci_online_test`
--
CREATE DATABASE IF NOT EXISTS `ci_online_test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ci_online_test`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL,
  `nip` char(12) NOT NULL,
  `nama_dosen` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `matkul_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nip`, `nama_dosen`, `email`, `matkul_id`) VALUES
(1, '123456789', 'Ahmad soleh', 'soleh.ipa@bsi.ac.id', 2),
(3, '87654321', 'Ibnu Dwi Lesmono, S.Kom, M.Kom', 'ibnu.dl@gmail.com', 6),
(4, '23040000', 'Yuni Siswantoro, M.Kom', 'yuniS@gmail.com', 5),
(5, '12180893', 'Firmansyah, M.Kom', 'firmansyah23@gmail.com', 1),
(7, '12345678', 'Indra Prana, MM', 'indra.ipa@bsi.ac.id', 7);

--
-- Trigger `dosen`
--
DELIMITER $$
CREATE TRIGGER `edit_user_dosen` BEFORE UPDATE ON `dosen` FOR EACH ROW UPDATE `users` SET `email` = NEW.email, `username` = NEW.nip WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hapus_user_dosen` BEFORE DELETE ON `dosen` FOR EACH ROW DELETE FROM `users` WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `groups`
--

CREATE TABLE `groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'dosen', 'Pembuat Soal dan ujian'),
(3, 'mahasiswa', 'Peserta Ujian');

-- --------------------------------------------------------

--
-- Struktur dari tabel `h_ujian`
--

CREATE TABLE `h_ujian` (
  `id` int(11) NOT NULL,
  `ujian_id` int(11) NOT NULL,
  `mahasiswa_id` int(11) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(11) NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `nilai_bobot` decimal(10,2) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `h_ujian`
--

INSERT INTO `h_ujian` (`id`, `ujian_id`, `mahasiswa_id`, `list_soal`, `list_jawaban`, `jml_benar`, `nilai`, `nilai_bobot`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES
(1, 4, 2, '2,5,3,4,1', '2:C:N,5:B:N,3:C:N,4:D:N,1:B:N', 2, '40.00', '500.00', '2020-05-25 15:12:57', '2020-05-25 16:12:57', 'N'),
(2, 5, 2, '11,12,10,9,8', '11:A:N,12:E:N,10:D:N,9:E:N,8:E:N', 3, '60.00', '2.00', '2020-06-18 00:51:43', '2020-06-18 01:51:43', 'N'),
(3, 6, 3, '13,8,11,9,10', '13:E:N,8:E:N,11:A:N,9:E:N,10:A:N', 5, '100.00', '2.00', '2020-06-18 09:35:49', '2020-06-18 10:35:49', 'N');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

CREATE TABLE `jurusan` (
  `id_jurusan` int(11) NOT NULL,
  `nama_jurusan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jurusan`
--

INSERT INTO `jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
(1, 'Sistem Informasi'),
(2, 'Teknik Informatika');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan_matkul`
--

CREATE TABLE `jurusan_matkul` (
  `id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jurusan_matkul`
--

INSERT INTO `jurusan_matkul` (`id`, `matkul_id`, `jurusan_id`) VALUES
(7, 2, 1),
(8, 2, 2),
(10, 5, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL,
  `nama_kelas` varchar(30) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`, `jurusan_id`) VALUES
(1, '12.1E.13', 1),
(2, '11.1A.13', 1),
(3, '12.4C.25', 1),
(7, '12.1A.10', 2),
(8, '12.1B.10', 2),
(10, '12.6C.25', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas_dosen`
--

CREATE TABLE `kelas_dosen` (
  `id` int(11) NOT NULL,
  `kelas_id` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kelas_dosen`
--

INSERT INTO `kelas_dosen` (`id`, `kelas_id`, `dosen_id`) VALUES
(1, 3, 1),
(2, 2, 1),
(3, 1, 1),
(11, 2, 3),
(12, 1, 3),
(13, 3, 3),
(15, 7, 7),
(16, 1, 7),
(17, 3, 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `nim` char(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `kelas_id` int(11) NOT NULL COMMENT 'kelas&jurusan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nama`, `nim`, `email`, `jenis_kelamin`, `kelas_id`) VALUES
(1, 'Widia Ningsih', '12181019', 'widiyaningsih311@gmail.com', 'P', 3),
(2, 'Nenty', '12180892', 'nenty230400@gmail.com', 'P', 3),
(3, 'Rindiyani', '12181781', 'rindiyani435@gmail.com', 'P', 3),
(4, 'Gracia Carina Mutiara', '12182200', 'graciacarinamutiara@gmail.com', 'P', 3),
(6, 'Dzikria Maulidina Sahidah', '12180901', 'dzikriasyahidah@gmail.com', 'P', 8),
(7, 'Soleh', '12345678', 'soleh@gmail.com', 'L', 10);

-- --------------------------------------------------------

--
-- Struktur dari tabel `matkul`
--

CREATE TABLE `matkul` (
  `id_matkul` int(11) NOT NULL,
  `nama_matkul` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `matkul`
--

INSERT INTO `matkul` (`id_matkul`, `nama_matkul`) VALUES
(1, 'ANALISA & PERANCANGAN SISTEM INFORMASI'),
(2, 'WEB PROGRAMMING III'),
(3, 'MANAJEMEN PROYEK SISTEM INFORMASI'),
(5, 'INTERAKSI MANUSIA KOMPUTER'),
(6, 'MULTIMEDIA'),
(7, 'METODE PENELITIAN'),
(8, 'JARINGAN KOMPTER');

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_ujian`
--

CREATE TABLE `m_ujian` (
  `id_ujian` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(11) NOT NULL,
  `waktu` int(11) NOT NULL,
  `jenis` enum('acak','urut') NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `terlambat` datetime NOT NULL,
  `token` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `m_ujian`
--

INSERT INTO `m_ujian` (`id_ujian`, `dosen_id`, `matkul_id`, `nama_ujian`, `jumlah_soal`, `waktu`, `jenis`, `tgl_mulai`, `terlambat`, `token`) VALUES
(1, 1, 1, 'First Test', 3, 1, 'acak', '2019-02-15 17:25:40', '2019-02-20 17:25:44', 'DPEHL'),
(2, 1, 1, 'Second Test', 3, 1, 'acak', '2019-02-16 10:05:08', '2019-02-17 10:05:10', 'TLBYW'),
(3, 3, 5, 'Try Out 01', 2, 1, 'acak', '2019-02-16 07:00:00', '2019-02-28 14:00:00', 'IFSDH'),
(4, 3, 6, 'UTS', 5, 60, 'acak', '2020-05-25 15:07:38', '2020-05-26 15:07:43', 'LLEBT'),
(5, 7, 7, 'UTS', 5, 60, 'acak', '2020-06-18 00:47:54', '2020-06-19 00:48:07', 'EFZFM'),
(6, 7, 7, 'UAS', 5, 60, 'acak', '2020-06-18 09:25:04', '2020-06-19 09:25:08', 'DZGTJ');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_soal`
--

CREATE TABLE `tb_soal` (
  `id_soal` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `bobot` int(11) NOT NULL,
  `file` varchar(255) NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `file_a` varchar(255) NOT NULL,
  `file_b` varchar(255) NOT NULL,
  `file_c` varchar(255) NOT NULL,
  `file_d` varchar(255) NOT NULL,
  `file_e` varchar(255) NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_soal`
--

INSERT INTO `tb_soal` (`id_soal`, `dosen_id`, `matkul_id`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `file_a`, `file_b`, `file_c`, `file_d`, `file_e`, `jawaban`, `created_on`, `updated_on`) VALUES
(1, 3, 6, 5, '', '', '<p>Pembawa informasi yang memungkinkan terjadinya transmisi data secara kontinyu. Melalui apa</p><p>informasi ditransmisikan…</p>', '<p>facebook</p>', '<p>Email</p>', '<p>telfon</p>', '<p>pos</p>', '<p>paket</p>', '', '', '', '', '', 'B', 1590392820, 1590392875),
(2, 3, 6, 5, '', '', '<p>Yang termasuk ke dalam kelompok media kontinyu adalah... </p>', '<p>audio</p>', '<p>video</p>', '<p>audio dan video</p>', '<p>gmail</p>', '<p>pos</p>', '', '', '', '', '', 'C', 1590392975, 1590392975),
(3, 3, 6, 5, '', '', '<p>Penggunaan teknologi video conference dan video broadcast termasuk ke dalam sistem multimedia</p><p>berbasis…</p>', '<p>jaringan</p>', '<p>saringan</p>', '<p>informasi</p>', '<p>media</p>', '<p>pos</p>', '', '', '', '', '', 'A', 1590393078, 1590393078),
(4, 3, 6, 5, '', '', '<p>Yang tidak termasuk ke dalam komponen utama sistem multimedia adalah…</p>', '<p>cara untuk meminta</p>', '<p>cara untuk makan</p>', '<p>cara untuk menghapus</p>', '<p>cara untuk berbagi itu indah</p>', '<p>cara untuk berbagi</p>', '', '', '', '', '', 'E', 1590393220, 1590393220),
(5, 3, 6, 5, '', '', '<p>Pembuatan tutorial, ensiklopedia (misal : microsoft encarta, instruksional), merupakan manfaat</p><p>multimedia dalam bidang…</p>', '<p>kedokteran</p>', '<p>perhotelan</p>', '<p>akuntan</p>', '<p>informasi</p>', '<p>pendidikan</p>', '', '', '', '', '', 'A', 1590393338, 1590393338),
(6, 5, 1, 5, '', '', '<p>sistem adalah elemen elemen yang saling berhubungan sa5\\tu dengan yang lainnya untuk mencapai suatu tujuan,adalah</p>', '<p>jogiyanto</p>', '<p>gorden b davis</p>', '<p>Drs.komarudin</p>', '<p>raymong Mc.leod</p>', '<p>kendal&jener</p>', '', '', '', '', '', 'D', 1590497515, 1590497515),
(7, 5, 1, 5, '', '', '<p>dibawah ini yang merupakan peranan dari analis sistem adalah</p>', '<p>penganalis sistem sebagai ahli pendukung</p>', '<p>penganalis sebagai ahli programmer</p>', '<p>penganalis sistem sebagai administrator database</p>', '<p>sebagai manajer proyek</p>', '<p>semua jawaban benar</p>', '', '', '', '', '', 'A', 1590497790, 1590497790),
(8, 7, 7, 20, '', '', '<p>Ada berapa Macam Model Tradisional…..</p>', '<p>2</p>', '<p>3</p>', '<p>4</p>', '<p>6</p>', '<p>5</p>', '', '', '', '', '', 'E', 1592411671, 1592411671),
(9, 7, 7, 20, '', '', '<p><span xss=removed>Macam-Macam Model Tradisional…..</span></p>', '<p><span xss=removed>Model Waterfall,</span> <span xss=removed>Model Concurrent</span></p>', '<p><span xss=removed>Model InkrementalProses,</span><span xss=removed> </span><span xss=removed>Model Proses Evolusi</span></p>', '<p><span xss=removed>Model Rational Unified Process, Model Concurrent</span></p>', '<p>Model Waterfall, Model Proses Evolusi, Model Concurrent</p>', '<p>Model Concurrent, Model Rational Unified Process, Model Proses Evolusi, Model Waterfall</p>', '', '', '', '', '', 'E', 1592411843, 1592411843),
(10, 7, 7, 20, '', '', '<p>Sebutkan Tahapan Model Waterfall…</p>', '<p>Communication, Planning,Modelling,Contruction, Deployment.</p>', '<p>Communication, Planning,Modelling, Deployment.</p>', '<p>Modelling,Contruction, Deployment</p>', '<p>Communication, Planning,Modell</p>', '<p>Planning,Modelling,Contruction.</p>', '', '', '', '', '', 'A', 1592411998, 1592411998),
(11, 7, 7, 20, '7dd3ab41e1d7cbba962f5f9dbdfcbaa0.png', 'image/png', '<p>Gambar di atas adalah…bar di atas adalah…</p>', '<p>Model Prototype</p>', '<p>Model Prototype</p>', '<ol><li>Model Concurrent</li></ol>', '<p>Model Proses Evolus</p>', '<p>Model Proses</p>', '', '', '', '', '', 'A', 1592414181, 1592414181),
(12, 7, 7, 20, '89aee7629b535e752694b76c89aa19dd.png', 'image/png', '<p>Gambar di atas adalah…bar di atas adalah…</p>', '<p>Model Prototype</p>', '<p>Model Prototype</p>', '<ol><li>Model Concurrent</li></ol>', '<p>Model Proses Evolus</p>', '<p>Model Proses</p>', '', '', '', '', '', 'A', 1592414191, 1592414191),
(13, 7, 7, 20, '5d63af77b5441d904561313b7d802e23.png', 'image/png', '<p>Gambar di atas adalah…</p>', '<p>Model Prototype</p>', '<p>Model Waterfal</p>', '<p>Model Concurrent</p>', '<p>Model Proses Evolus</p>', '<p>Model spiral</p>', '', '', '', '', '', 'E', 1592415327, 1592415327);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `activation_selector` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `forgotten_password_selector` varchar(255) DEFAULT NULL,
  `forgotten_password_code` varchar(255) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_selector` varchar(255) DEFAULT NULL,
  `remember_code` varchar(255) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `email`, `activation_selector`, `activation_code`, `forgotten_password_selector`, `forgotten_password_code`, `forgotten_password_time`, `remember_selector`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'Administrator', '$2y$12$tGY.AtcyXrh7WmccdbT1rOuKEcTsKH6sIUmDr0ore1yN4LnKTTtuu', 'admin@admin.com', NULL, '', NULL, NULL, NULL, NULL, NULL, 1268889823, 1593250798, 1, 'Admin', 'Istrator', 'ADMIN', '0'),
(9, '::1', '12180892', '$2y$10$Yo9BzEnfaKDrUlhBZkt6Ve5LVv/gxzfnkrn8Ur3K2EJ1MVhfIA/bi', 'nenty230400@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1589099140, 1592829918, 1, 'Nenty', 'Nenty', NULL, NULL),
(10, '::1', '12181019', '$2y$10$OyU6UcRE.ywT.AA0epEIpeadWoJwxd/TAJB/Cmr7CQG/p82djhQyS', 'widiyaningsih311@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1589100942, NULL, 1, 'Widia', 'Ningsih', NULL, NULL),
(11, '::1', '12181781', '$2y$10$AbtcuhndisV7w5ABbZtFYemnIwhFWVlpCmBwoRT1lDeIuZr2/SzK2', 'rindiyani435@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1589101030, 1593250640, 1, 'Rindiyani', 'Rindiyani', NULL, NULL),
(12, '::1', '12182200', '$2y$10$AQx2jvcH4LkhK8v4ZrkDbOeQAuuXAgtpLakxFk5xmAG.xmp7dEA1e', 'graciacarinamutiara@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1589101168, NULL, 1, 'Gracia', 'Mutiara', NULL, NULL),
(13, '::1', '12180901', '$2y$10$cq9CAESzmjocRGZtigD5eeLLbRzN20ylQnvBSkZaNsVolhWNEo.la', 'dzikriasyahidah@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1589101254, NULL, 1, 'Dzikria', 'Sahidah', NULL, NULL),
(15, '::1', '87654321', '$2y$10$inyRP8aNp/BzlISwXjXXh.pkouVQLmmSSG6b7zEe7sOPpXew2rb6W', 'ibnu.dl@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1590393924, 1592448411, 1, 'Ibnu', 'M.Kom', NULL, NULL),
(16, '::1', '12180893', '$2y$10$WwiBl/47x4MWsEAevCenaO8nZK6lCISw4jCJ12oZQv2iPHOw/SNX6', 'firmansyah23@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1590498093, NULL, 1, 'Firmansyah,', 'M.Kom', NULL, NULL),
(17, '::1', '23040000', '$2y$10$DXDk6I7x.oYXYHucvsuiZOW5vUN4gXMGW4M2R3bCa.PZBkB/swVT.', 'yuniS@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1590498510, NULL, 1, 'Yuni', 'M.Kom', NULL, NULL),
(18, '::1', '123456789', '$2y$10$yqcShoCT3S87SpYUOkek0.seVT5tzy4yp2eVgWEucxfwq6Vdx.STq', 'soleh.ipa@bsi.ac.id', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1592409440, 1592409488, 1, 'Indra', 'MM', NULL, NULL),
(19, '::1', '12345678', '$2y$10$MRykmiklhgwfN2iG/vgq7.5iY31Mu6gXCTUczhNAN037MVRiFC1Sa', 'indra.ipa@bsi.ac.id', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1592411352, 1593250755, 1, 'Indra', 'MM', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users_groups`
--

CREATE TABLE `users_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(3, 1, 1),
(11, 9, 3),
(12, 10, 3),
(13, 11, 3),
(14, 12, 3),
(15, 13, 3),
(17, 15, 2),
(18, 16, 2),
(19, 17, 2),
(20, 18, 2),
(21, 19, 2);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indeks untuk tabel `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `h_ujian`
--
ALTER TABLE `h_ujian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ujian_id` (`ujian_id`),
  ADD KEY `mahasiswa_id` (`mahasiswa_id`);

--
-- Indeks untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id_jurusan`);

--
-- Indeks untuk tabel `jurusan_matkul`
--
ALTER TABLE `jurusan_matkul`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jurusan_id` (`jurusan_id`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indeks untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `jurusan_id` (`jurusan_id`);

--
-- Indeks untuk tabel `kelas_dosen`
--
ALTER TABLE `kelas_dosen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kelas_id` (`kelas_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indeks untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD UNIQUE KEY `nim` (`nim`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `kelas_id` (`kelas_id`);

--
-- Indeks untuk tabel `matkul`
--
ALTER TABLE `matkul`
  ADD PRIMARY KEY (`id_matkul`);

--
-- Indeks untuk tabel `m_ujian`
--
ALTER TABLE `m_ujian`
  ADD PRIMARY KEY (`id_ujian`),
  ADD KEY `matkul_id` (`matkul_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indeks untuk tabel `tb_soal`
--
ALTER TABLE `tb_soal`
  ADD PRIMARY KEY (`id_soal`),
  ADD KEY `matkul_id` (`matkul_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_activation_selector` (`activation_selector`),
  ADD UNIQUE KEY `uc_forgotten_password_selector` (`forgotten_password_selector`),
  ADD UNIQUE KEY `uc_remember_selector` (`remember_selector`),
  ADD UNIQUE KEY `uc_email` (`email`) USING BTREE;

--
-- Indeks untuk tabel `users_groups`
--
ALTER TABLE `users_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  ADD KEY `fk_users_groups_users1_idx` (`user_id`),
  ADD KEY `fk_users_groups_groups1_idx` (`group_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `groups`
--
ALTER TABLE `groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `h_ujian`
--
ALTER TABLE `h_ujian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id_jurusan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `jurusan_matkul`
--
ALTER TABLE `jurusan_matkul`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `kelas_dosen`
--
ALTER TABLE `kelas_dosen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `matkul`
--
ALTER TABLE `matkul`
  MODIFY `id_matkul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `m_ujian`
--
ALTER TABLE `m_ujian`
  MODIFY `id_ujian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tb_soal`
--
ALTER TABLE `tb_soal`
  MODIFY `id_soal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `users_groups`
--
ALTER TABLE `users_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Ketidakleluasaan untuk tabel `h_ujian`
--
ALTER TABLE `h_ujian`
  ADD CONSTRAINT `h_ujian_ibfk_1` FOREIGN KEY (`ujian_id`) REFERENCES `m_ujian` (`id_ujian`),
  ADD CONSTRAINT `h_ujian_ibfk_2` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswa` (`id_mahasiswa`);

--
-- Ketidakleluasaan untuk tabel `jurusan_matkul`
--
ALTER TABLE `jurusan_matkul`
  ADD CONSTRAINT `jurusan_matkul_ibfk_1` FOREIGN KEY (`jurusan_id`) REFERENCES `jurusan` (`id_jurusan`),
  ADD CONSTRAINT `jurusan_matkul_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Ketidakleluasaan untuk tabel `kelas_dosen`
--
ALTER TABLE `kelas_dosen`
  ADD CONSTRAINT `kelas_dosen_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`),
  ADD CONSTRAINT `kelas_dosen_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id_kelas`);

--
-- Ketidakleluasaan untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id_kelas`);

--
-- Ketidakleluasaan untuk tabel `m_ujian`
--
ALTER TABLE `m_ujian`
  ADD CONSTRAINT `m_ujian_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`),
  ADD CONSTRAINT `m_ujian_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Ketidakleluasaan untuk tabel `tb_soal`
--
ALTER TABLE `tb_soal`
  ADD CONSTRAINT `tb_soal_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`),
  ADD CONSTRAINT `tb_soal_ibfk_2` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`);

--
-- Ketidakleluasaan untuk tabel `users_groups`
--
ALTER TABLE `users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
--
-- Database: `my-employee`
--
CREATE DATABASE IF NOT EXISTS `my-employee` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `my-employee`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `image` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `date_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `image`, `password`, `role_id`, `is_active`, `date_created`) VALUES
(4, 'Anggi Sudrajad', 'anggisdr1903@gmail.com', 'bahan_tutorial.jpg', '$2y$10$x7HTyzl/X4xf0q0gDbW5r.BVuPOXV85adEK/W5GdzK2ghVcLQjBkS', 1, 1, 1574530750),
(9, 'Anggi Sudrajad', 'mcdonald.and1903@gmail.com', 'default.jpg', '$2y$10$ruZ/P801443p0NOm7lRqMeG1gBd.Kz9a3bK96n6bGSl/N1D92FcMW', 2, 1, 1575063866);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_access_menu`
--

CREATE TABLE `user_access_menu` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user_access_menu`
--

INSERT INTO `user_access_menu` (`id`, `role_id`, `menu_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(8, 1, 3),
(9, 3, 3),
(10, 3, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_menu`
--

CREATE TABLE `user_menu` (
  `id` int(11) NOT NULL,
  `menu` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user_menu`
--

INSERT INTO `user_menu` (`id`, `menu`) VALUES
(1, 'Admin'),
(2, 'User'),
(3, 'Menu');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user_role`
--

INSERT INTO `user_role` (`id`, `role`) VALUES
(1, 'Administrator'),
(2, 'Member'),
(8, 'Auxilarry');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_sub_menu`
--

CREATE TABLE `user_sub_menu` (
  `id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `url` varchar(128) NOT NULL,
  `icon` varchar(128) NOT NULL,
  `is_active` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user_sub_menu`
--

INSERT INTO `user_sub_menu` (`id`, `menu_id`, `title`, `url`, `icon`, `is_active`) VALUES
(1, 1, 'Dashboard', 'admin', 'fas fa-fw fa-tachometer-alt', 1),
(2, 2, 'My Profile', 'user', 'fas fa-fw fa-user', 1),
(3, 2, 'Edit Profile', 'user/edit', 'fas fa-fw fa-user-edit', 1),
(4, 3, 'Menu Management', 'menu', 'fas fa-fw fa-folder', 1),
(5, 3, 'SubMenu Management', 'menu/submenu', 'fas fa-fw fa-folder-open', 1),
(7, 1, 'Role', 'admin/role', 'fas fa-fw fa-user-cog', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_token`
--

CREATE TABLE `user_token` (
  `id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `token` varchar(128) NOT NULL,
  `date_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_access_menu`
--
ALTER TABLE `user_access_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_menu`
--
ALTER TABLE `user_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_token`
--
ALTER TABLE `user_token`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `user_access_menu`
--
ALTER TABLE `user_access_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `user_menu`
--
ALTER TABLE `user_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `penduduk`
--
CREATE DATABASE IF NOT EXISTS `penduduk` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `penduduk`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_agama`
--

CREATE TABLE `tbl_agama` (
  `kode` int(11) NOT NULL,
  `uraian` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_agama`
--

INSERT INTO `tbl_agama` (`kode`, `uraian`) VALUES
(3, 'Kristen'),
(4, 'Islam'),
(5, 'Hindu'),
(7, 'Bundha');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kematian`
--

CREATE TABLE `tbl_kematian` (
  `kode` int(11) NOT NULL,
  `kd_warga` int(11) DEFAULT NULL,
  `tgl_kematian` date DEFAULT NULL,
  `tempat` varchar(200) DEFAULT NULL,
  `penyebab_kematian` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_kematian`
--

INSERT INTO `tbl_kematian` (`kode`, `kd_warga`, `tgl_kematian`, `tempat`, `penyebab_kematian`) VALUES
(1, 8, '2018-10-12', '222222', '222');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_lahir`
--

CREATE TABLE `tbl_lahir` (
  `kode` int(11) NOT NULL,
  `kd_warga` int(11) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `berat_lahir` varchar(50) DEFAULT NULL,
  `panjang_lahir` varchar(50) DEFAULT NULL,
  `nama_ibu` varchar(40) DEFAULT NULL,
  `nama_ayah` varchar(40) DEFAULT NULL,
  `saksi` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_lurah`
--

CREATE TABLE `tbl_lurah` (
  `kode` int(11) NOT NULL,
  `uraian` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_lurah`
--

INSERT INTO `tbl_lurah` (`kode`, `uraian`) VALUES
(2, 'Damai Sejati'),
(3, 'Desa Damai');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pekerjaan`
--

CREATE TABLE `tbl_pekerjaan` (
  `kode` int(11) NOT NULL,
  `uraian` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pekerjaan`
--

INSERT INTO `tbl_pekerjaan` (`kode`, `uraian`) VALUES
(3, 'Tidak Bekerja'),
(4, 'Petani2');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendatang`
--

CREATE TABLE `tbl_pendatang` (
  `kode` int(11) NOT NULL,
  `kd_warga` int(11) DEFAULT NULL,
  `desa_asal` varchar(100) DEFAULT NULL,
  `kecamatan_asal` varchar(100) DEFAULT NULL,
  `alamat_asal` varchar(100) DEFAULT NULL,
  `tgl_datang` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendidikan`
--

CREATE TABLE `tbl_pendidikan` (
  `kode` int(11) NOT NULL,
  `uraian` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pendidikan`
--

INSERT INTO `tbl_pendidikan` (`kode`, `uraian`) VALUES
(3, 'SD'),
(4, 'SMP'),
(5, 'SMA'),
(6, 'D1'),
(7, 'D2'),
(8, 'D3'),
(9, 'S1'),
(10, 'S2');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_penduduk_tetap`
--

CREATE TABLE `tbl_penduduk_tetap` (
  `kode` int(11) NOT NULL,
  `kd_warga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_penduduk_tetap`
--

INSERT INTO `tbl_penduduk_tetap` (`kode`, `kd_warga`) VALUES
(1, 0),
(2, 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pindah`
--

CREATE TABLE `tbl_pindah` (
  `kode` int(11) NOT NULL,
  `kd_warga` int(11) DEFAULT NULL,
  `alasan_pindah` varchar(100) DEFAULT NULL,
  `alamat_pindah` varchar(100) DEFAULT NULL,
  `kecamatan` varchar(100) DEFAULT NULL,
  `lurah` varchar(100) DEFAULT NULL,
  `tgl_pindah` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pindah`
--

INSERT INTO `tbl_pindah` (`kode`, `kd_warga`, `alasan_pindah`, `alamat_pindah`, `kecamatan`, `lurah`, `tgl_pindah`) VALUES
(1, 9, 'wwwww  ', 'eeee', 'rrrrr', 'rrrr  ', '2018-10-18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user`
--

CREATE TABLE `tbl_user` (
  `kode` int(11) NOT NULL,
  `user_name` varchar(40) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user`
--

INSERT INTO `tbl_user` (`kode`, `user_name`, `password`) VALUES
(2, 'ADMIN', 'ADMIN'),
(5, 'nenty', '230400');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_warga`
--

CREATE TABLE `tbl_warga` (
  `kode` int(11) NOT NULL,
  `kd_lurah` int(11) NOT NULL,
  `kd_pekerjaan` int(11) NOT NULL,
  `kd_pendidikan` int(11) NOT NULL,
  `kd_agama` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `jenis_kelamin` varchar(20) NOT NULL,
  `alamat` text NOT NULL,
  `kecamatan` varchar(30) NOT NULL,
  `kabupaten` varchar(30) NOT NULL,
  `provinsi` varchar(30) NOT NULL,
  `negara` varchar(30) NOT NULL,
  `status_kawin` varchar(20) NOT NULL,
  `tempat_lahir` varchar(100) NOT NULL,
  `jenis` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_warga`
--

INSERT INTO `tbl_warga` (`kode`, `kd_lurah`, `kd_pekerjaan`, `kd_pendidikan`, `kd_agama`, `nik`, `nama`, `tgl_lahir`, `jenis_kelamin`, `alamat`, `kecamatan`, `kabupaten`, `provinsi`, `negara`, `status_kawin`, `tempat_lahir`, `jenis`) VALUES
(6, 2, 3, 6, 3, '92929292929', 'DELISMAN HULU', '2018-10-18', 'Laki-Laki', '22', '22', '22', 'Sumatera Utara', 'WNI', 'Belum Menikah', 'MEDAN', 'Pendatang'),
(7, 2, 3, 7, 7, '222222222222', 'Afriadi', '2018-10-18', 'Laki-Laki', 'Bilal', '2', '22', 'Sumatera Utara', 'WNI222', 'Sudah Menikah', 'MEDAN', 'Tetap'),
(8, 2, 3, 3, 3, '3333333333', 'H.Ishaq Naharuddin MA', '2018-10-15', 'Perempuan', '2', '2', '2', 'Sumatera Utara2', 'WNI', 'Sudah Menikah', 'mEDNASFADSFADSFADS', 'Meninggal'),
(9, 2, 3, 3, 3, '2222222', '2222', '2018-10-12', 'Perempuan', '2', '33', '33', 'Sumatera Utara2', 'WNI', 'Sudah Menikah', '222', 'Pindah'),
(10, 2, 3, 3, 3, '333333', '333333333', '2018-10-20', 'Perempuan', '', '3', '3', 'Sumatera Utara', 'WNI', 'Sudah Menikah', '333', 'Lahir');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_datang`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_datang` (
`kode` int(11)
,`kd_warga` int(11)
,`desa_asal` varchar(100)
,`kecamatan_asal` varchar(100)
,`alamat_asal` varchar(100)
,`tgl_datang` date
,`kd_lurah` int(11)
,`kd_pekerjaan` int(11)
,`kd_pendidikan` int(11)
,`kd_agama` int(11)
,`nik` varchar(16)
,`nama` varchar(45)
,`tgl_lahir` date
,`jenis_kelamin` varchar(20)
,`alamat` text
,`kecamatan` varchar(30)
,`kabupaten` varchar(30)
,`provinsi` varchar(30)
,`negara` varchar(30)
,`status_kawin` varchar(20)
,`tempat_lahir` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_kematian`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_kematian` (
`kode` int(11)
,`kd_warga` int(11)
,`tgl_kematian` date
,`tempat` varchar(200)
,`penyebab_kematian` varchar(100)
,`kd_lurah` int(11)
,`kd_pekerjaan` int(11)
,`kd_pendidikan` int(11)
,`kd_agama` int(11)
,`nik` varchar(16)
,`nama` varchar(45)
,`tgl_lahir` date
,`jenis_kelamin` varchar(20)
,`alamat` text
,`kecamatan` varchar(30)
,`kabupaten` varchar(30)
,`provinsi` varchar(30)
,`negara` varchar(30)
,`status_kawin` varchar(20)
,`tempat_lahir` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_lahir`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_lahir` (
`kode` int(11)
,`kd_warga` int(11)
,`tgl_lahir` date
,`berat_lahir` varchar(50)
,`panjang_lahir` varchar(50)
,`nama_ibu` varchar(40)
,`nama_ayah` varchar(40)
,`saksi` varchar(40)
,`kd_lurah` int(11)
,`kd_pekerjaan` int(11)
,`kd_pendidikan` int(11)
,`kd_agama` int(11)
,`nik` varchar(16)
,`nama` varchar(45)
,`jenis_kelamin` varchar(20)
,`alamat` text
,`kecamatan` varchar(30)
,`kabupaten` varchar(30)
,`provinsi` varchar(30)
,`negara` varchar(30)
,`status_kawin` varchar(20)
,`tempat_lahir` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_penduduk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_penduduk` (
`kode` int(11)
,`kd_lurah` int(11)
,`kd_pekerjaan` int(11)
,`kd_pendidikan` int(11)
,`kd_agama` int(11)
,`nik` varchar(16)
,`nama` varchar(45)
,`tgl_lahir` date
,`jenis_kelamin` varchar(20)
,`alamat` text
,`kecamatan` varchar(30)
,`kabupaten` varchar(30)
,`provinsi` varchar(30)
,`negara` varchar(30)
,`status_kawin` varchar(20)
,`tempat_lahir` varchar(100)
,`jenis` varchar(20)
,`agama` varchar(40)
,`pekerjaan` varchar(40)
,`lurah` varchar(40)
,`pendidikan` varchar(40)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_pindah`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_pindah` (
`kd_lurah` int(11)
,`kd_pekerjaan` int(11)
,`kd_pendidikan` int(11)
,`kd_agama` int(11)
,`nik` varchar(16)
,`nama` varchar(45)
,`tgl_lahir` date
,`jenis_kelamin` varchar(20)
,`alamat` text
,`kabupaten` varchar(30)
,`provinsi` varchar(30)
,`negara` varchar(30)
,`status_kawin` varchar(20)
,`tempat_lahir` varchar(100)
,`kode` int(11)
,`kd_warga` int(11)
,`alasan_pindah` varchar(100)
,`alamat_pindah` varchar(100)
,`kecamatan` varchar(100)
,`lurah` varchar(100)
,`tgl_pindah` date
,`kec_awal` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_tetap`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_tetap` (
`kd_lurah` int(11)
,`kd_pekerjaan` int(11)
,`kd_pendidikan` int(11)
,`kd_agama` int(11)
,`nik` varchar(16)
,`nama` varchar(45)
,`tgl_lahir` date
,`jenis_kelamin` varchar(20)
,`alamat` text
,`kecamatan` varchar(30)
,`kabupaten` varchar(30)
,`provinsi` varchar(30)
,`negara` varchar(30)
,`status_kawin` varchar(20)
,`tempat_lahir` varchar(100)
,`kd_warga` int(11)
,`kode` int(11)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `v_datang`
--
DROP TABLE IF EXISTS `v_datang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_datang`  AS  select `tbl_pendatang`.`kode` AS `kode`,`tbl_pendatang`.`kd_warga` AS `kd_warga`,`tbl_pendatang`.`desa_asal` AS `desa_asal`,`tbl_pendatang`.`kecamatan_asal` AS `kecamatan_asal`,`tbl_pendatang`.`alamat_asal` AS `alamat_asal`,`tbl_pendatang`.`tgl_datang` AS `tgl_datang`,`tbl_warga`.`kd_lurah` AS `kd_lurah`,`tbl_warga`.`kd_pekerjaan` AS `kd_pekerjaan`,`tbl_warga`.`kd_pendidikan` AS `kd_pendidikan`,`tbl_warga`.`kd_agama` AS `kd_agama`,`tbl_warga`.`nik` AS `nik`,`tbl_warga`.`nama` AS `nama`,`tbl_warga`.`tgl_lahir` AS `tgl_lahir`,`tbl_warga`.`jenis_kelamin` AS `jenis_kelamin`,`tbl_warga`.`alamat` AS `alamat`,`tbl_warga`.`kecamatan` AS `kecamatan`,`tbl_warga`.`kabupaten` AS `kabupaten`,`tbl_warga`.`provinsi` AS `provinsi`,`tbl_warga`.`negara` AS `negara`,`tbl_warga`.`status_kawin` AS `status_kawin`,`tbl_warga`.`tempat_lahir` AS `tempat_lahir` from (`tbl_pendatang` join `tbl_warga` on((`tbl_warga`.`kode` = `tbl_pendatang`.`kd_warga`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_kematian`
--
DROP TABLE IF EXISTS `v_kematian`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_kematian`  AS  select `tbl_kematian`.`kode` AS `kode`,`tbl_kematian`.`kd_warga` AS `kd_warga`,`tbl_kematian`.`tgl_kematian` AS `tgl_kematian`,`tbl_kematian`.`tempat` AS `tempat`,`tbl_kematian`.`penyebab_kematian` AS `penyebab_kematian`,`tbl_warga`.`kd_lurah` AS `kd_lurah`,`tbl_warga`.`kd_pekerjaan` AS `kd_pekerjaan`,`tbl_warga`.`kd_pendidikan` AS `kd_pendidikan`,`tbl_warga`.`kd_agama` AS `kd_agama`,`tbl_warga`.`nik` AS `nik`,`tbl_warga`.`nama` AS `nama`,`tbl_warga`.`tgl_lahir` AS `tgl_lahir`,`tbl_warga`.`jenis_kelamin` AS `jenis_kelamin`,`tbl_warga`.`alamat` AS `alamat`,`tbl_warga`.`kecamatan` AS `kecamatan`,`tbl_warga`.`kabupaten` AS `kabupaten`,`tbl_warga`.`provinsi` AS `provinsi`,`tbl_warga`.`negara` AS `negara`,`tbl_warga`.`status_kawin` AS `status_kawin`,`tbl_warga`.`tempat_lahir` AS `tempat_lahir` from (`tbl_kematian` join `tbl_warga` on((`tbl_warga`.`kode` = `tbl_kematian`.`kd_warga`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_lahir`
--
DROP TABLE IF EXISTS `v_lahir`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_lahir`  AS  select `tbl_lahir`.`kode` AS `kode`,`tbl_lahir`.`kd_warga` AS `kd_warga`,`tbl_lahir`.`tgl_lahir` AS `tgl_lahir`,`tbl_lahir`.`berat_lahir` AS `berat_lahir`,`tbl_lahir`.`panjang_lahir` AS `panjang_lahir`,`tbl_lahir`.`nama_ibu` AS `nama_ibu`,`tbl_lahir`.`nama_ayah` AS `nama_ayah`,`tbl_lahir`.`saksi` AS `saksi`,`tbl_warga`.`kd_lurah` AS `kd_lurah`,`tbl_warga`.`kd_pekerjaan` AS `kd_pekerjaan`,`tbl_warga`.`kd_pendidikan` AS `kd_pendidikan`,`tbl_warga`.`kd_agama` AS `kd_agama`,`tbl_warga`.`nik` AS `nik`,`tbl_warga`.`nama` AS `nama`,`tbl_warga`.`jenis_kelamin` AS `jenis_kelamin`,`tbl_warga`.`alamat` AS `alamat`,`tbl_warga`.`kecamatan` AS `kecamatan`,`tbl_warga`.`kabupaten` AS `kabupaten`,`tbl_warga`.`provinsi` AS `provinsi`,`tbl_warga`.`negara` AS `negara`,`tbl_warga`.`status_kawin` AS `status_kawin`,`tbl_warga`.`tempat_lahir` AS `tempat_lahir` from (`tbl_lahir` join `tbl_warga` on((`tbl_warga`.`kode` = `tbl_lahir`.`kd_warga`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_penduduk`
--
DROP TABLE IF EXISTS `v_penduduk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_penduduk`  AS  select `tbl_warga`.`kode` AS `kode`,`tbl_warga`.`kd_lurah` AS `kd_lurah`,`tbl_warga`.`kd_pekerjaan` AS `kd_pekerjaan`,`tbl_warga`.`kd_pendidikan` AS `kd_pendidikan`,`tbl_warga`.`kd_agama` AS `kd_agama`,`tbl_warga`.`nik` AS `nik`,`tbl_warga`.`nama` AS `nama`,`tbl_warga`.`tgl_lahir` AS `tgl_lahir`,`tbl_warga`.`jenis_kelamin` AS `jenis_kelamin`,`tbl_warga`.`alamat` AS `alamat`,`tbl_warga`.`kecamatan` AS `kecamatan`,`tbl_warga`.`kabupaten` AS `kabupaten`,`tbl_warga`.`provinsi` AS `provinsi`,`tbl_warga`.`negara` AS `negara`,`tbl_warga`.`status_kawin` AS `status_kawin`,`tbl_warga`.`tempat_lahir` AS `tempat_lahir`,`tbl_warga`.`jenis` AS `jenis`,`tbl_agama`.`uraian` AS `agama`,`tbl_pekerjaan`.`uraian` AS `pekerjaan`,`tbl_lurah`.`uraian` AS `lurah`,`tbl_pendidikan`.`uraian` AS `pendidikan` from ((((`tbl_warga` join `tbl_pekerjaan` on((`tbl_pekerjaan`.`kode` = `tbl_warga`.`kd_pekerjaan`))) join `tbl_agama` on((`tbl_agama`.`kode` = `tbl_warga`.`kd_agama`))) join `tbl_lurah` on((`tbl_lurah`.`kode` = `tbl_warga`.`kd_lurah`))) join `tbl_pendidikan` on((`tbl_pendidikan`.`kode` = `tbl_warga`.`kd_pendidikan`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_pindah`
--
DROP TABLE IF EXISTS `v_pindah`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pindah`  AS  select `tbl_warga`.`kd_lurah` AS `kd_lurah`,`tbl_warga`.`kd_pekerjaan` AS `kd_pekerjaan`,`tbl_warga`.`kd_pendidikan` AS `kd_pendidikan`,`tbl_warga`.`kd_agama` AS `kd_agama`,`tbl_warga`.`nik` AS `nik`,`tbl_warga`.`nama` AS `nama`,`tbl_warga`.`tgl_lahir` AS `tgl_lahir`,`tbl_warga`.`jenis_kelamin` AS `jenis_kelamin`,`tbl_warga`.`alamat` AS `alamat`,`tbl_warga`.`kabupaten` AS `kabupaten`,`tbl_warga`.`provinsi` AS `provinsi`,`tbl_warga`.`negara` AS `negara`,`tbl_warga`.`status_kawin` AS `status_kawin`,`tbl_warga`.`tempat_lahir` AS `tempat_lahir`,`tbl_pindah`.`kode` AS `kode`,`tbl_pindah`.`kd_warga` AS `kd_warga`,`tbl_pindah`.`alasan_pindah` AS `alasan_pindah`,`tbl_pindah`.`alamat_pindah` AS `alamat_pindah`,`tbl_pindah`.`kecamatan` AS `kecamatan`,`tbl_pindah`.`lurah` AS `lurah`,`tbl_pindah`.`tgl_pindah` AS `tgl_pindah`,`tbl_warga`.`kecamatan` AS `kec_awal` from (`tbl_warga` join `tbl_pindah` on((`tbl_warga`.`kode` = `tbl_pindah`.`kd_warga`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_tetap`
--
DROP TABLE IF EXISTS `v_tetap`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tetap`  AS  select `tbl_warga`.`kd_lurah` AS `kd_lurah`,`tbl_warga`.`kd_pekerjaan` AS `kd_pekerjaan`,`tbl_warga`.`kd_pendidikan` AS `kd_pendidikan`,`tbl_warga`.`kd_agama` AS `kd_agama`,`tbl_warga`.`nik` AS `nik`,`tbl_warga`.`nama` AS `nama`,`tbl_warga`.`tgl_lahir` AS `tgl_lahir`,`tbl_warga`.`jenis_kelamin` AS `jenis_kelamin`,`tbl_warga`.`alamat` AS `alamat`,`tbl_warga`.`kecamatan` AS `kecamatan`,`tbl_warga`.`kabupaten` AS `kabupaten`,`tbl_warga`.`provinsi` AS `provinsi`,`tbl_warga`.`negara` AS `negara`,`tbl_warga`.`status_kawin` AS `status_kawin`,`tbl_warga`.`tempat_lahir` AS `tempat_lahir`,`tbl_penduduk_tetap`.`kd_warga` AS `kd_warga`,`tbl_penduduk_tetap`.`kode` AS `kode` from (`tbl_warga` join `tbl_penduduk_tetap` on((`tbl_warga`.`kode` = `tbl_penduduk_tetap`.`kd_warga`))) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_agama`
--
ALTER TABLE `tbl_agama`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_kematian`
--
ALTER TABLE `tbl_kematian`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_lahir`
--
ALTER TABLE `tbl_lahir`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_lurah`
--
ALTER TABLE `tbl_lurah`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_pekerjaan`
--
ALTER TABLE `tbl_pekerjaan`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_pendatang`
--
ALTER TABLE `tbl_pendatang`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_pendidikan`
--
ALTER TABLE `tbl_pendidikan`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_penduduk_tetap`
--
ALTER TABLE `tbl_penduduk_tetap`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_pindah`
--
ALTER TABLE `tbl_pindah`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `tbl_warga`
--
ALTER TABLE `tbl_warga`
  ADD PRIMARY KEY (`kode`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_agama`
--
ALTER TABLE `tbl_agama`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tbl_kematian`
--
ALTER TABLE `tbl_kematian`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tbl_lahir`
--
ALTER TABLE `tbl_lahir`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_lurah`
--
ALTER TABLE `tbl_lurah`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_pekerjaan`
--
ALTER TABLE `tbl_pekerjaan`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendatang`
--
ALTER TABLE `tbl_pendatang`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendidikan`
--
ALTER TABLE `tbl_pendidikan`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_penduduk_tetap`
--
ALTER TABLE `tbl_penduduk_tetap`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_pindah`
--
ALTER TABLE `tbl_pindah`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_warga`
--
ALTER TABLE `tbl_warga`
  MODIFY `kode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Database: `pesek`
--
CREATE DATABASE IF NOT EXISTS `pesek` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pesek`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `akun`
--

CREATE TABLE `akun` (
  `nis` int(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `nama_lengkap` varchar(50) NOT NULL,
  `kelas` varchar(50) NOT NULL,
  `jurusan` varchar(50) NOT NULL,
  `status_vote` varchar(13) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `akun`
--

INSERT INTO `akun` (`nis`, `username`, `nama_lengkap`, `kelas`, `jurusan`, `status_vote`) VALUES
(1, 'jovvi', 'Joviandro nopier marbun', '12', 'RPL', '0'),
(2, 'Yiek', 'Yiek alfian', '12', 'RPL', '0'),
(3, 'Fahrizal', 'Fahrizal Syaripdin', '12', 'RPL', '0'),
(4, 'aqsa', 'Muhammad Aqsyal', '12', 'RPL', '0'),
(5, 'Aldin', 'Aldin abb', '12', 'RPL', '0'),
(8, 'Fadla', 'Fadlawalad dimas Zo Charli siregar', '12', 'RPL', '0'),
(9, 'Kevin', 'Kevin Hendra Wijaya', '12', 'RPL', '1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_vote`
--

CREATE TABLE `log_vote` (
  `user` text NOT NULL,
  `tanggal_waktu` varchar(255) NOT NULL,
  `add_log` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data untuk tabel `log_vote`
--

INSERT INTO `log_vote` (`user`, `tanggal_waktu`, `add_log`) VALUES
('Joviandro nopier marbun,12,RPL', 'Fri, 06 Oct 2017 08:58:14 +0700', 'Login'),
('Joviandro nopier marbun,12,RPL', 'Fri, 06 Oct 2017 08:58:33 +0700', 'ketua2,wakil1'),
('Joviandro nopier marbun,12,RPL', 'Fri, 06 Oct 2017 09:00:28 +0700', 'ketua3,wakil3'),
('Joviandro nopier marbun,12,RPL', 'Fri, 06 Oct 2017 09:00:31 +0700', 'Logout'),
('Joviandro nopier marbun,12,RPL', 'Fri, 06 Oct 2017 09:02:52 +0700', 'Login'),
('Joviandro nopier marbun,12,RPL', 'Fri, 06 Oct 2017 09:03:53 +0700', 'ketua1,wakil3'),
('Joviandro nopier marbun,12,RPL', 'Fri, 06 Oct 2017 09:03:56 +0700', 'Logout'),
('Fahrizal Syaripdin,12,RPL', 'Fri, 06 Oct 2017 19:38:53 +0700', 'Login'),
('Fahrizal Syaripdin,12,RPL', 'Fri, 06 Oct 2017 19:42:25 +0700', 'Logout'),
('Muhammad Aqsyal,12,RPL', 'Sat, 07 Oct 2017 17:23:59 +0700', 'Login'),
('Aldin abb,12,RPL', 'Sat, 07 Oct 2017 17:25:49 +0700', 'Login'),
('Aldin abb,12,RPL', 'Sat, 07 Oct 2017 17:26:59 +0700', 'ketua1,wakil1'),
('Muhammad Aqsyal,12,RPL', 'Sat, 07 Oct 2017 17:26:59 +0700', 'ketua1,wakil1'),
('Aldin abb,12,RPL', 'Sat, 07 Oct 2017 17:27:03 +0700', 'Logout'),
('Muhammad Aqsyal,12,RPL', 'Sat, 07 Oct 2017 17:27:03 +0700', 'Logout'),
('Yiek alfian,12,RPL', 'Sat, 07 Oct 2017 17:27:38 +0700', 'Login'),
('Fadlawalad dimas Zo Charli siregar,12,RPL', 'Sat, 07 Oct 2017 17:27:48 +0700', 'Login'),
('Yiek alfian,12,RPL', 'Sat, 07 Oct 2017 17:28:17 +0700', 'ketua1,wakil1'),
('Fadlawalad dimas Zo Charli siregar,12,RPL', 'Sat, 07 Oct 2017 17:28:17 +0700', 'ketua1,wakil1'),
('Yiek alfian,12,RPL', 'Sat, 07 Oct 2017 17:28:20 +0700', 'Logout'),
('Fadlawalad dimas Zo Charli siregar,12,RPL', 'Sat, 07 Oct 2017 17:28:20 +0700', 'Logout'),
('Fahrizal Syaripdin,12,RPL', 'Sat, 07 Oct 2017 17:32:45 +0700', 'Login'),
('Fahrizal Syaripdin,12,RPL', 'Sat, 07 Oct 2017 17:33:43 +0700', 'Logout'),
('Fahrizal Syaripdin,12,RPL', 'Sat, 07 Oct 2017 18:36:52 +0700', 'Login'),
('Fahrizal Syaripdin,12,RPL', 'Sat, 07 Oct 2017 19:15:58 +0700', 'Logout'),
('Fahrizal Syaripdin,12,RPL', 'Mon, 16 Oct 2017 15:18:28 +0700', 'Login'),
('Fahrizal Syaripdin,12,RPL', 'Mon, 16 Oct 2017 15:20:13 +0700', 'Logout'),
('Fahrizal Syaripdin,12,RPL', 'Mon, 16 Oct 2017 17:15:41 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 07:38:00 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 07:46:26 +0700', 'Logout'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 07:47:00 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 07:58:21 +0700', 'Logout'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 08:05:44 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 08:40:11 +0700', 'Logout'),
('Fahrizal Syaripdin,12,RPL', 'Tue, 17 Oct 2017 08:44:50 +0700', 'Login'),
('Fahrizal Syaripdin,12,RPL', 'Tue, 17 Oct 2017 08:45:10 +0700', 'ketua3,wakil3'),
('Fahrizal Syaripdin,12,RPL', 'Tue, 17 Oct 2017 08:45:13 +0700', 'Logout'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 11:55:24 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 15:54:49 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 16:14:36 +0700', 'Logout'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 16:15:12 +0700', 'Logout'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 16:15:24 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 16:17:18 +0700', 'Logout'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 16:27:40 +0700', 'Login'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 17:17:58 +0700', 'ketua3,wakil3'),
('Kevin Hendra Wijaya,12,RPL', 'Tue, 17 Oct 2017 17:17:59 +0700', 'Logout'),
('Joviandro nopier marbun,12,RPL', 'Thu, 19 Dec 2019 19:59:48 +0700', 'Logout'),
(',,', 'Thu, 19 Dec 2019 20:00:00 +0700', 'Logout'),
('Muhammad Aqsyal,12,RPL', 'Thu, 19 Dec 2019 20:00:32 +0700', 'Login'),
('Muhammad Aqsyal,12,RPL', 'Thu, 19 Dec 2019 20:09:48 +0700', 'Logout'),
('Fahrizal Syaripdin,12,RPL', 'Thu, 19 Dec 2019 20:10:00 +0700', 'Login'),
('Yiek alfian,12,RPL', 'Thu, 19 Dec 2019 20:11:47 +0700', 'Login'),
('Fahrizal Syaripdin,12,RPL', 'Thu, 19 Dec 2019 20:15:10 +0700', 'Login');

-- --------------------------------------------------------

--
-- Struktur dari tabel `vote`
--

CREATE TABLE `vote` (
  `calon` varchar(33) NOT NULL,
  `nama_calon` varchar(50) NOT NULL,
  `deskripsi_calon` text NOT NULL,
  `foto_calon` text NOT NULL,
  `jumlah_vote` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `vote`
--

INSERT INTO `vote` (`calon`, `nama_calon`, `deskripsi_calon`, `foto_calon`, `jumlah_vote`) VALUES
('ketua1', 'Ikbal maulana', 'Saya tidak tau harus berkata apa', '11.jpg', 20),
('ketua2', 'Fahrizal syaripudin', 'Saya sangat bahagia bisa masuk osis', '22.jpg', 30),
('ketua3', 'JOvianro', 'asdsad', '3.jpg', 11),
('wakil1', 'Wawan kurniawan', 'Update status expert', '12.jpg', 11),
('wakil2', 'Muhammad aqsal', 'Tempat satu dua tiga empat', '2.jpg', 12),
('wakil3', 'Noor fadhil fadal ahmad', 'Tidak ada', '3.jpg', 20);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`nis`);

--
-- Indeks untuk tabel `vote`
--
ALTER TABLE `vote`
  ADD PRIMARY KEY (`calon`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Dumping data untuk tabel `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'server', 'ci_online_test', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"ci_online_test\",\"my-employee\",\"penduduk\",\"pesek\",\"phpmyadmin\",\"pusta\",\"pustaka\",\"sepasang-sepatu\",\"sepatu\",\"test\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Struktur tabel @TABLE@\",\"latex_structure_continued_caption\":\"Struktur tabel @TABLE@ (dilanjutkan)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Isi tabel @TABLE@\",\"latex_data_continued_caption\":\"Isi tabel @TABLE@ (dilanjutkan)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

--
-- Dumping data untuk tabel `pma__navigationhiding`
--

INSERT INTO `pma__navigationhiding` (`username`, `item_name`, `item_type`, `db_name`, `table_name`) VALUES
('root', 'user', 'table', 'pustaka', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data untuk tabel `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"ci_online_test\",\"table\":\"h_ujian\"},{\"db\":\"ci_online_test\",\"table\":\"dosen\"},{\"db\":\"ci_online_test\",\"table\":\"jurusan_matkul\"},{\"db\":\"ci_online_test\",\"table\":\"kelas\"},{\"db\":\"ci_online_test\",\"table\":\"kelas_dosen\"},{\"db\":\"ci_online_test\",\"table\":\"login_attempts\"},{\"db\":\"ci_online_test\",\"table\":\"matkul\"},{\"db\":\"ci_online_test\",\"table\":\"mahasiswa\"},{\"db\":\"ci_online_test\",\"table\":\"tb_soal\"},{\"db\":\"ci_online_test\",\"table\":\"users\"}]');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data untuk tabel `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'pusta', 'buku', '{\"CREATE_TIME\":\"2019-10-18 19:01:54\"}', '2020-04-21 12:34:56'),
('root', 'pusta', 'user', '{\"CREATE_TIME\":\"2020-04-05 18:51:43\"}', '2020-04-21 12:34:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data untuk tabel `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2020-06-27 12:39:13', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"id\"}');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indeks untuk tabel `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indeks untuk tabel `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indeks untuk tabel `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indeks untuk tabel `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indeks untuk tabel `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indeks untuk tabel `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indeks untuk tabel `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indeks untuk tabel `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indeks untuk tabel `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indeks untuk tabel `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `pusta`
--
CREATE DATABASE IF NOT EXISTS `pusta` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pusta`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking`
--

CREATE TABLE `booking` (
  `id_booking` varchar(12) NOT NULL,
  `tgl_booking` date NOT NULL,
  `batas_ambil` date NOT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `booking`
--

INSERT INTO `booking` (`id_booking`, `tgl_booking`, `batas_ambil`, `id_user`) VALUES
('11042020001', '2020-04-11', '2020-04-13', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking_detail`
--

CREATE TABLE `booking_detail` (
  `id` int(11) NOT NULL,
  `id_booking` varchar(12) DEFAULT NULL,
  `id_buku` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `booking_detail`
--

INSERT INTO `booking_detail` (`id`, `id_booking`, `id_buku`) VALUES
(2, '02042020001', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id` int(11) NOT NULL,
  `judul_buku` varchar(128) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `pengarang` varchar(64) NOT NULL,
  `penerbit` varchar(64) NOT NULL,
  `tahun_terbit` year(4) NOT NULL,
  `isbn` varchar(64) NOT NULL,
  `stok` int(11) NOT NULL,
  `dipinjam` int(11) NOT NULL,
  `dibooking` int(11) NOT NULL,
  `image` varchar(256) NOT NULL DEFAULT 'book-default-cover.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id`, `judul_buku`, `id_kategori`, `pengarang`, `penerbit`, `tahun_terbit`, `isbn`, `stok`, `dipinjam`, `dibooking`, `image`) VALUES
(1, 'statika dengan program komputer', 1, 'Ahmad khoirul amin', 'deep publish', 2014, '1234567', -2, 1, 9, 'img1557404689.jpg'),
(2, 'mudah belajar komputer untuk anak', 1, 'Bambang agus setiawan', 'huta media', 2014, '12345678', 0, 3, 6, 'img1557404613.jpg'),
(4, 'Detektif conan ep 200', 9, 'okigawa sasuke', 'cultura', 2016, '12345678910', 5, 0, 0, 'img1557403658.jpg'),
(5, 'PHP Komplet', 1, 'jubilee', 'elex media komputindo', 2014, '123456789', 5, 1, 1, 'img1557403502.jpg'),
(6, 'Bahasa indonesia', 2, 'Umri nur\'aini dan indriyani', 'pustaka perbukuan', 2015, '123456', 2, 0, 1, 'img1557403156.jpg'),
(8, 'kolaborasi codeigniter dan ajax dalam perancangan', 1, 'Anton subagia', 'Elex media komputindo', 2017, '1234', 5, 0, 0, 'img1557402703.jpg'),
(9, 'From hobby to money', 4, 'Deasylawati', 'elex media komputindo', 2015, '123', 5, 0, 0, 'img1557402455.jpg'),
(10, 'Buku saku pramuka', 8, 'Rudi himawan', 'pusat perbukuaan', 2016, '1234567891011', 6, 0, 0, 'img1557402397.jpg'),
(15, 'komunikasi lintas', 5, 'Dr. deddy kurnia', 'published', 2015, '12345', 5, 0, 0, 'img1557403156.jpg'),
(19, 'Keajaiban  bumi', 3, 'Nurul ihsan', 'luxima', 2014, '123456789101112', 4, 0, 1, 'img1555522493.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pinjam`
--

CREATE TABLE `detail_pinjam` (
  `no_pinjam` varchar(12) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `denda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` int(5) NOT NULL,
  `nama_kategori` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `nama_kategori`) VALUES
(1, 'komputer'),
(2, 'bahasa'),
(3, 'sains'),
(4, 'hobby'),
(5, 'komunikasi'),
(6, 'hukum'),
(7, 'agama'),
(8, 'populer'),
(9, 'komik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pinjam`
--

CREATE TABLE `pinjam` (
  `no_pinjam` varchar(12) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `id_booking` int(12) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `tgl_pengembalian` date NOT NULL,
  `status` enum('pinjam','kembali') NOT NULL DEFAULT 'pinjam',
  `total_denda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `role`
--

INSERT INTO `role` (`id`, `role`) VALUES
(1, 'admministrator'),
(2, 'member');

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp`
--

CREATE TABLE `temp` (
  `id` int(11) NOT NULL,
  `tgl_booking` datetime DEFAULT NULL,
  `id_user` varchar(12) DEFAULT NULL,
  `email_user` varchar(128) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `judul_buku` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `penulis` varchar(128) NOT NULL,
  `penerbit` varchar(128) NOT NULL,
  `tahun_terbit` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `temp`
--

INSERT INTO `temp` (`id`, `tgl_booking`, `id_user`, `email_user`, `id_buku`, `judul_buku`, `image`, `penulis`, `penerbit`, `tahun_terbit`) VALUES
(1, '2020-04-17 13:44:40', '2', 'dzikriasyahidah@gmail.com', 8, 'kolaborasi codeigniter dan ajax dalam perancangan', 'img1557402703.jpg', 'Anton subagia', 'Elex media komputindo', 2017),
(2, '2020-04-21 19:21:25', '3', 'nenty230400@gmail.com', 4, 'Detektif conan ep 200', 'img1557403658.jpg', 'okigawa sasuke', 'cultura', 2016);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(128) NOT NULL,
  `alamat` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `tanggal_input` int(11) NOT NULL,
  `image` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `alamat`, `email`, `password`, `role_id`, `is_active`, `tanggal_input`, `image`) VALUES
(2, 'Dzikria Maulidina Sahidah', 'jl.kamal', 'dzikriasyahidah@gmail.com', '$2y$10$M4N8f3zEaQkz7o7571crz.NcV9aYdcOEqO5Iq3PkxlW3VrTfYdVUO', 2, 1, 1586613378, 'pro1586612666.jpg'),
(3, 'Nenty', 'jl.asia baru 1 no.24 E', 'nenty230400@gmail.com', '$2y$10$LFR2rPsFeN80RxJ/od0CY.xfFOWRXMwy32BxAqcorbPiv1JcxWwPa', 2, 1, 1587471661, 'default.jpg'),
(4, 'Nenty', '', 'nenti230400@gmail.com', '$2y$10$htry88/cwiz/L88gQlPVcuMHySrcXq7PiSuJWh3IDWmXhwthKQvYO', 2, 1, 1587472339, 'default.jpg');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`);

--
-- Indeks untuk tabel `booking_detail`
--
ALTER TABLE `booking_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pinjam`
--
ALTER TABLE `pinjam`
  ADD PRIMARY KEY (`no_pinjam`);

--
-- Indeks untuk tabel `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `temp`
--
ALTER TABLE `temp`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `booking_detail`
--
ALTER TABLE `booking_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `temp`
--
ALTER TABLE `temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Database: `pustaka`
--
CREATE DATABASE IF NOT EXISTS `pustaka` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pustaka`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `alamat`
--

CREATE TABLE `alamat` (
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking`
--

CREATE TABLE `booking` (
  `id_booking` varchar(12) NOT NULL,
  `tgl_booking` date NOT NULL,
  `batas_ambil` date NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking_detail`
--

CREATE TABLE `booking_detail` (
  `id` int(11) NOT NULL,
  `id_booking` varchar(12) NOT NULL,
  `id_buku` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `booking_detail`
--

INSERT INTO `booking_detail` (`id`, `id_booking`, `id_buku`) VALUES
(1, '13042020001', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id` int(11) NOT NULL,
  `judul_buku` varchar(128) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `pengarang` varchar(64) NOT NULL,
  `penerbit` varchar(64) NOT NULL,
  `tahun_terbit` year(4) NOT NULL,
  `isbn` varchar(64) NOT NULL,
  `stok` int(11) NOT NULL,
  `dipinjam` int(11) NOT NULL,
  `dibooking` int(11) NOT NULL,
  `image` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id`, `judul_buku`, `id_kategori`, `pengarang`, `penerbit`, `tahun_terbit`, `isbn`, `stok`, `dipinjam`, `dibooking`, `image`) VALUES
(1, 'statistika dan proram komputer', 1, 'Ahmad Kholiqul Amin', 'Deep Publish', 2014, '9786022809432', 5, 1, 2, 'img1557402455.jpg'),
(2, 'mudah belajar komputer untuk anak', 1, 'Bambang agus setiawan', 'Huta media', 2014, '9786025118500', 6, 2, 1, 'img1557402397.jpg'),
(5, 'PHP komplet', 1, 'Jubilee', 'Elex media komputindo', 2017, '8346753547', 5, 1, 1, 'img1555522493.jpg'),
(10, 'Detektif Conan ep 200', 9, 'Okigawa sasuke', 'Cultura', 2016, '874387583987', 5, 0, 0, 'img1557401455.jpg'),
(14, 'Bahasa indonesia', 2, 'Umri nur\'aini dan indriyani', 'Pusat perbukuan', 2015, '757254724884', 3, 0, 0, 'img1557402703.jpg'),
(15, 'Komunikasi lintas budaya', 5, 'Dr.Dedy kurnia', 'Published', 2015, '878674646488', 5, 0, 0, 'img1557403156.jpg'),
(16, 'Kolaborasi codeignniter dan ajax daklam perancangan', 1, 'Anton subagian', 'Alex median komputindo', 2017, '43345356577', 5, 0, 0, 'img1557403502.jpg'),
(17, 'From hobby to money', 4, 'Deasylawati', 'Elex media komputindo', 2015, '8796867879', 6, -1, 0, 'img1557403658.jpg'),
(18, 'Buku saku pramuka', 8, 'Rudi himawan', 'Pusat perbukuan ', 2016, '97868687978796', 6, 0, 0, 'img1557404613.img'),
(19, 'Rahasia keajaiban bumi', 3, 'Nurul ihsan', 'Luxima', 2014, '5657565768868', 5, 0, 0, 'img1557404689.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pinjam`
--

CREATE TABLE `detail_pinjam` (
  `no_pinjam` varchar(12) CHARACTER SET utf8mb4 NOT NULL,
  `id_buku` int(11) NOT NULL,
  `denda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `detail_pinjam`
--

INSERT INTO `detail_pinjam` (`no_pinjam`, `id_buku`, `denda`) VALUES
('27042020001', 2, 5000),
('02052020002', 17, 5000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(5) NOT NULL,
  `nama_kategori` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(1, 'komputer'),
(2, 'Bahasa'),
(3, 'sains'),
(4, 'Hobby'),
(5, 'Komunikasi'),
(6, 'Hukum'),
(7, 'Agama'),
(8, 'Populer'),
(9, 'Komik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pinjam`
--

CREATE TABLE `pinjam` (
  `no_pinjam` varchar(12) CHARACTER SET utf8mb4 NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `id_booking` varchar(12) CHARACTER SET utf8mb4 NOT NULL,
  `id_user` int(11) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `tgl_pengembalian` date NOT NULL,
  `status` enum('Pinjam','Kembali') CHARACTER SET utf8mb4 NOT NULL DEFAULT 'Pinjam',
  `total_denda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pinjam`
--

INSERT INTO `pinjam` (`no_pinjam`, `tgl_pinjam`, `id_booking`, `id_user`, `tgl_kembali`, `tgl_pengembalian`, `status`, `total_denda`) VALUES
('02052020002', '2020-05-02', '02052020001', 1, '2020-05-05', '2020-05-02', 'Kembali', 0),
('27042020001', '2020-04-27', '27042020001', 0, '2020-04-30', '2020-04-27', 'Kembali', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `role`
--

INSERT INTO `role` (`id`, `role`) VALUES
(1, 'administrator'),
(2, 'member');

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp`
--

CREATE TABLE `temp` (
  `id` int(11) NOT NULL,
  `tgl_booking` datetime DEFAULT NULL,
  `id_user` varchar(12) NOT NULL,
  `email_user` varchar(128) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `judul_buku` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `penulis` varchar(128) NOT NULL,
  `penerbit` varchar(128) NOT NULL,
  `tahun_terbit` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `image` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `tanggal_input` int(11) NOT NULL,
  `alamat` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `email`, `image`, `password`, `role_id`, `is_active`, `tanggal_input`, `alamat`) VALUES
(1, 'Nenty', 'nenty230400@gmail.com', 'default.jpg', '$2y$10$6bksvUD9YOWzw6KTpB9WkumAwZERRyUHk2KrpRGNB.DsrE5WVuZf.', 1, 1, 1588338446, 'jl.asia baru 1 no.24 E');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`);

--
-- Indeks untuk tabel `booking_detail`
--
ALTER TABLE `booking_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `pinjam`
--
ALTER TABLE `pinjam`
  ADD PRIMARY KEY (`no_pinjam`);

--
-- Indeks untuk tabel `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `temp`
--
ALTER TABLE `temp`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `booking_detail`
--
ALTER TABLE `booking_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `temp`
--
ALTER TABLE `temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `sepasang-sepatu`
--
CREATE DATABASE IF NOT EXISTS `sepasang-sepatu` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sepasang-sepatu`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tabel_sepatu`
--

CREATE TABLE `tabel_sepatu` (
  `id` int(10) NOT NULL,
  `merk` varchar(20) NOT NULL,
  `harga` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tabel_sepatu`
--

INSERT INTO `tabel_sepatu` (`id`, `merk`, `harga`) VALUES
(1, 'Nike', 0),
(2, 'Adidas', 0),
(3, 'Kickers', 0),
(4, 'Nike', 250000),
(5, 'Adidas', 275000),
(6, 'Kickers', 300000),
(7, 'Eiger', 375000),
(8, 'Bucherri', 400000),
(9, 'Nike', 250000),
(10, 'Adidas', 275000),
(11, 'Kickers', 300000),
(12, 'Eiger', 375000),
(13, 'Bucherri', 400000);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tabel_sepatu`
--
ALTER TABLE `tabel_sepatu`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tabel_sepatu`
--
ALTER TABLE `tabel_sepatu`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- Database: `sepatu`
--
CREATE DATABASE IF NOT EXISTS `sepatu` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sepatu`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tabel_sepatu`
--

CREATE TABLE `tabel_sepatu` (
  `id` int(5) NOT NULL,
  `merk` varchar(20) NOT NULL,
  `harga` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tabel_sepatu`
--

INSERT INTO `tabel_sepatu` (`id`, `merk`, `harga`) VALUES
(1, 'Nike', 250000),
(2, 'Adidas', 275000),
(3, 'Kickers', 300000),
(4, 'Eiger', 375000),
(5, 'Bucherri', 400000);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tabel_sepatu`
--
ALTER TABLE `tabel_sepatu`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tabel_sepatu`
--
ALTER TABLE `tabel_sepatu`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
