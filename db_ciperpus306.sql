CREATE DATABASE IF NOT EXISTS 'db_ciperpus306';
USE 'db_ciperpus306';

/* Tabel Buku */
CREATE TABLE IF NOT EXISTS 'buku'(
  'id_buku' int(10) unsigned NOT NULL AUTO_INCREMENT,
  'kode_buku' VARCHAR(10) NOT NULL,
  'id_judul' int(10) unsigned NOT NULL,
  'is_ada' enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY ('id_buku'),
  UNIQUE KEY 'uq_kode_buku' ('kode_buku'),
  KEY 'fk_buku_judul' FOREIGN KEY ('id_judul') REFERENCES 'judul' ('id_judul') ON DELETE CASCADE ON UPDATE CASCADE
) 
ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/* Tabel Denda */
CREATE TABLE IF NOT EXISTS 'denda' (
  'id_pinjam' int(10) unsigned NOT NULL,
  'jumlah' int(10) unsigned NOT NULL,
  'tanggal_pembayaran' date NOT NULL,
  'is_dibayar' enum('y','n') NOT NULL DEFAULT 'n', PRIMARY KEY ('id_pinjam'),
    CONSTRAINT 'fk_denda_peminjaman' FOREIGN KEY ('id_pinjam') REFERENCES 'peminjaman' ('id_pinjam')
    ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/* Tabel Judul */
CREATE TABLE IF NOT EXISTS 'judul' (
  'id_judul' int(10) unsigned NOT NULL AUTO_INCREMENT,
  'isbn' VARCHAR(15) NOT NULL DEFAULT '0',
  'judul_buku' VARCHAR(255) NOT NULL,
  'penulis' VARCHAR(255) NOT NULL,
  'cover' VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ('id_judul'),
  UNIQUE KEY 'uq_isbn' ('isbn')
)
ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/* Tabel Kelas */
CREATE TABLE IF NOT EXISTS 'kelas' (
  'id_kelas' int(10) unsigned NOT NULL AUTO_INCREMENT,
  'nama_kelas' VARCHAR(255) NOT NULL,
  PRIMARY KEY ('id_kelas')
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/* Tabel Peminjaman */
CREATE TABLE IF NOT EXISTS 'peminjaman' (
  'id_pinjam' int(10) unsigned NOT NULL AUTO_INCREMENT,
  'tanggal_pinjam' date NOT NULL,
  'id_siswa' int(10) unsigned NOT NULL,
  'tanggal_kembali' date DEFAULT NULL,
  'is_kembali' enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY ('id_pinjam'),
  KEY 'fk_peminjaman_siswa' ('id_siswa'),
  KEY 'fk_peminjaman_buku' ('id_buku'),
  CONSTRAINT 'fk_peminjaman_buku' FOREIGN KEY ('id_buku') REFERENCES 'buku' ('id_buku') ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT 'fk_peminjaman_siswa' FOREIGN KEY ('id_siswa') REFERENCES 'siswa' ('id_siswa') ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/* Tabel Siswa */
CREATE TABLE IF NOT EXISTS 'siswa' (
  'id_siswa' int(10) unsigned NOT NULL AUTO_INCREMENT,
  'nis' VARCHAR(4) NOT NULL,
  'nama_siswa' VARCHAR(255) NOT NULL,
  'jenis_kelamin' enum('L','P') NOT NULL,
  'id_kelas' int(10) unsigned NOT NULL,
  PRIMARY KEY ('id_siswa'),
  UNIQUE KEY 'uq_nisn' ('nis'),
  KEY 'fk_siswa_kelas' ('id_kelas'),
  CONSTRAINT 'fk_siswa_kelas' FOREIGN KEY ('id_kelas') REFERENCES 'kelas' ('id_kelas') ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/* Tabel User */
CREATE TABLE IF NOT EXISTS 'user' (
  'id_user' int(10) unsigned NOT NULL AUTO_INCREMENT,
  'nama_user' VARCHAR(255) NOT NULL,
  'username' VARCHAR(255) NOT NULL,
  'password' VARCHAR(255) NOT NULL,
  'level' enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY ('id_user'),
  UNIQUE KEY 'uq_username' ('username')
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;