/*
  Warnings:

  - The primary key for the `order` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `IdBarang` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `idorder` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `order_list` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `order_list` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `order` DROP FOREIGN KEY `order_IdBarang_fkey`;

-- DropForeignKey
ALTER TABLE `order` DROP FOREIGN KEY `order_id_fkey`;

-- DropForeignKey
ALTER TABLE `order_list` DROP FOREIGN KEY `order_list_IdBarang_fkey`;

-- AlterTable
ALTER TABLE `order` DROP PRIMARY KEY,
    DROP COLUMN `IdBarang`,
    DROP COLUMN `idorder`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `idBarang` INTEGER NULL,
    ADD COLUMN `iduser` INTEGER NULL,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `ekspedisi` ENUM('reguler', 'express', 'sameDay', 'instant') NOT NULL DEFAULT 'reguler',
    MODIFY `status` ENUM('pesananBerhasilDibuat', 'pesananDiterima', 'pesananDitolak', 'pesananDikirimKeEkspedisi', 'transitDiKotaTujuan', 'dikirimKeAlamatTujuan', 'diterima') NOT NULL DEFAULT 'pesananBerhasilDibuat',
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `order_list` DROP COLUMN `createdAt`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `idOrder` INTEGER NULL,
    ADD COLUMN `note` TEXT NOT NULL DEFAULT '',
    MODIFY `IdBarang` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `order_list` ADD CONSTRAINT `order_list_idOrder_fkey` FOREIGN KEY (`idOrder`) REFERENCES `order`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order_list` ADD CONSTRAINT `order_list_IdBarang_fkey` FOREIGN KEY (`IdBarang`) REFERENCES `barang`(`idBarang`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_iduser_fkey` FOREIGN KEY (`iduser`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_idBarang_fkey` FOREIGN KEY (`idBarang`) REFERENCES `barang`(`idBarang`) ON DELETE SET NULL ON UPDATE CASCADE;
