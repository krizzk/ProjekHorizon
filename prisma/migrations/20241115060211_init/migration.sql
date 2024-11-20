/*
  Warnings:

  - You are about to drop the `oder_list` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `oder_list` DROP FOREIGN KEY `oder_list_IdBarang_fkey`;

-- DropTable
DROP TABLE `oder_list`;

-- CreateTable
CREATE TABLE `order_list` (
    `idDetailTransaksi` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT '',
    `IdBarang` INTEGER NOT NULL DEFAULT 0,
    `jumlahBarang` INTEGER NOT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`idDetailTransaksi`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `order_list` ADD CONSTRAINT `order_list_IdBarang_fkey` FOREIGN KEY (`IdBarang`) REFERENCES `barang`(`idBarang`) ON DELETE RESTRICT ON UPDATE CASCADE;
