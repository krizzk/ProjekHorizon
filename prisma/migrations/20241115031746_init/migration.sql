-- AlterTable
ALTER TABLE `order` ADD COLUMN `IdBarang` INTEGER NOT NULL DEFAULT 0;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_IdBarang_fkey` FOREIGN KEY (`IdBarang`) REFERENCES `barang`(`idBarang`) ON DELETE RESTRICT ON UPDATE CASCADE;
