-- CreateTable
CREATE TABLE `Admin` (
    `IdAdmin` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` TEXT NOT NULL,
    `kontak` VARCHAR(191) NOT NULL DEFAULT '',
    `alamat` VARCHAR(191) NOT NULL DEFAULT '',
    `username` VARCHAR(191) NOT NULL DEFAULT '',
    `password` VARCHAR(191) NOT NULL DEFAULT '',

    UNIQUE INDEX `Admin_alamat_key`(`alamat`),
    PRIMARY KEY (`IdAdmin`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `barang` (
    `idBarang` INTEGER NOT NULL AUTO_INCREMENT,
    `NamaBarang` VARCHAR(191) NOT NULL DEFAULT '',
    `BeratBarang` INTEGER NOT NULL DEFAULT 11,
    `BanyakBarang` INTEGER NOT NULL DEFAULT 11,
    `AlamatBarang` VARCHAR(255) NOT NULL,
    `HargaBarang` DOUBLE NOT NULL,
    `FotoBarang` VARCHAR(191) NOT NULL DEFAULT '',

    PRIMARY KEY (`idBarang`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `detailTransaksi` (
    `idDetailTransaksi` VARCHAR(191) NOT NULL,
    `IdBarang` INTEGER NOT NULL,
    `TotalBarang` INTEGER NOT NULL DEFAULT 11,
    `TotalPembayaran` BOOLEAN NOT NULL,

    UNIQUE INDEX `detailTransaksi_idDetailTransaksi_key`(`idDetailTransaksi`),
    PRIMARY KEY (`idDetailTransaksi`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transaksi` (
    `idTransaksi` INTEGER NOT NULL AUTO_INCREMENT,
    `ekspedisi` VARCHAR(255) NOT NULL,
    `statusTransaksi` VARCHAR(255) NOT NULL,
    `TanggalTransaksi` VARCHAR(255) NOT NULL,
    `JenisPembayaran` ENUM('Cash', 'eMoney') NOT NULL DEFAULT 'Cash',

    PRIMARY KEY (`idTransaksi`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pelanggan` (
    `idPelanggan` INTEGER NOT NULL AUTO_INCREMENT,
    `NamaPelanggan` VARCHAR(191) NOT NULL DEFAULT '',
    `TanggalLahir` INTEGER NOT NULL DEFAULT 11,
    `KontakPelanggan` VARCHAR(255) NOT NULL,
    `AlamatPelanggan` VARCHAR(255) NOT NULL,
    `username` VARCHAR(191) NOT NULL DEFAULT '',
    `password` VARCHAR(191) NOT NULL DEFAULT '',

    PRIMARY KEY (`idPelanggan`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `detailTransaksi` ADD CONSTRAINT `detailTransaksi_IdBarang_fkey` FOREIGN KEY (`IdBarang`) REFERENCES `barang`(`idBarang`) ON DELETE RESTRICT ON UPDATE CASCADE;
