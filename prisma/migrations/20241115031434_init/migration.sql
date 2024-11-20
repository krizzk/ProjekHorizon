/*
  Warnings:

  - You are about to drop the `detailtransaksi` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `transaksi` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `detailtransaksi` DROP FOREIGN KEY `detailTransaksi_IdBarang_fkey`;

-- DropForeignKey
ALTER TABLE `transaksi` DROP FOREIGN KEY `transaksi_id_fkey`;

-- DropTable
DROP TABLE `detailtransaksi`;

-- DropTable
DROP TABLE `transaksi`;

-- CreateTable
CREATE TABLE `oder_list` (
    `idDetailTransaksi` VARCHAR(191) NOT NULL,
    `IdBarang` INTEGER NOT NULL DEFAULT 0,
    `jumlahBarang` INTEGER NOT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `oder_list_idDetailTransaksi_key`(`idDetailTransaksi`),
    PRIMARY KEY (`idDetailTransaksi`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `order` (
    `idTransaksi` INTEGER NOT NULL AUTO_INCREMENT,
    `id` INTEGER NOT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `TotalPembayaran` INTEGER NOT NULL DEFAULT 0,
    `JenisPembayaran` ENUM('dana', 'cod', 'qris', 'ovo', 'gopay', 'linkaja', 'vitualAccountTransfer') NOT NULL DEFAULT 'cod',
    `ekspedisi` ENUM('reguler', 'express', 'sameDay', 'instant') NOT NULL,
    `status` ENUM('pesananDiterima', 'pesananDitolak', 'pesananDikirimKeEkspedisi', 'transitDiKotaTujuan', 'dikirimKeAlamatTujuan', 'diterima') NOT NULL,

    PRIMARY KEY (`idTransaksi`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `oder_list` ADD CONSTRAINT `oder_list_IdBarang_fkey` FOREIGN KEY (`IdBarang`) REFERENCES `barang`(`idBarang`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_id_fkey` FOREIGN KEY (`id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
