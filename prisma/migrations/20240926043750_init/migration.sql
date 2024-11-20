/*
  Warnings:

  - You are about to drop the column `AlamatBarang` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `BanyakBarang` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `BeratBarang` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `FotoBarang` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `HargaBarang` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `NamaBarang` on the `barang` table. All the data in the column will be lost.
  - Added the required column `alamatBarang` to the `barang` table without a default value. This is not possible if the table is not empty.
  - Added the required column `deskripsi` to the `barang` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `barang` DROP COLUMN `AlamatBarang`,
    DROP COLUMN `BanyakBarang`,
    DROP COLUMN `BeratBarang`,
    DROP COLUMN `FotoBarang`,
    DROP COLUMN `HargaBarang`,
    DROP COLUMN `NamaBarang`,
    ADD COLUMN `alamatBarang` VARCHAR(255) NOT NULL,
    ADD COLUMN `banyakBarang` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `deskripsi` TEXT NOT NULL,
    ADD COLUMN `fotoBarang` VARCHAR(191) NOT NULL DEFAULT '',
    ADD COLUMN `hargaBarang` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `namaBarang` VARCHAR(191) NOT NULL DEFAULT '';
