/*
  Warnings:

  - A unique constraint covering the columns `[uuid]` on the table `barang` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[uuid]` on the table `pelanggan` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `uuid` to the `barang` table without a default value. This is not possible if the table is not empty.
  - Added the required column `uuid` to the `pelanggan` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `barang` ADD COLUMN `uuid` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `pelanggan` ADD COLUMN `uuid` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `barang_uuid_key` ON `barang`(`uuid`);

-- CreateIndex
CREATE UNIQUE INDEX `pelanggan_uuid_key` ON `pelanggan`(`uuid`);
