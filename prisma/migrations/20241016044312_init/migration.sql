/*
  Warnings:

  - You are about to alter the column `alamatBarang` on the `barang` table. The data in that column could be lost. The data in that column will be cast from `VarChar(255)` to `VarChar(191)`.

*/
-- AlterTable
ALTER TABLE `barang` MODIFY `alamatBarang` VARCHAR(191) NOT NULL DEFAULT '';
