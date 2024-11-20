/*
  Warnings:

  - The primary key for the `oder_list` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `idDetailTransaksi` on the `oder_list` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.

*/
-- DropIndex
DROP INDEX `oder_list_idDetailTransaksi_key` ON `oder_list`;

-- AlterTable
ALTER TABLE `oder_list` DROP PRIMARY KEY,
    ADD COLUMN `uuid` VARCHAR(191) NOT NULL DEFAULT '',
    MODIFY `idDetailTransaksi` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`idDetailTransaksi`);

-- AlterTable
ALTER TABLE `order` ADD COLUMN `uuid` VARCHAR(191) NOT NULL DEFAULT '';
