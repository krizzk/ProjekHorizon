/*
  Warnings:

  - The primary key for the `order` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idTransaksi` on the `order` table. All the data in the column will be lost.
  - Added the required column `idorder` to the `order` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `order` DROP PRIMARY KEY,
    DROP COLUMN `idTransaksi`,
    ADD COLUMN `idorder` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`idorder`);
