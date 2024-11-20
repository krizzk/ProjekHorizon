/*
  Warnings:

  - You are about to drop the column `TotalBarang` on the `detailtransaksi` table. All the data in the column will be lost.
  - You are about to drop the column `TotalPembayaran` on the `detailtransaksi` table. All the data in the column will be lost.
  - You are about to drop the column `TanggalTransaksi` on the `transaksi` table. All the data in the column will be lost.
  - You are about to drop the column `statusTransaksi` on the `transaksi` table. All the data in the column will be lost.
  - You are about to alter the column `JenisPembayaran` on the `transaksi` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(0))` to `Enum(EnumId(1))`.
  - Added the required column `status` to the `transaksi` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `detailtransaksi` DROP COLUMN `TotalBarang`,
    DROP COLUMN `TotalPembayaran`,
    ADD COLUMN `jumlahBarang` INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `transaksi` DROP COLUMN `TanggalTransaksi`,
    DROP COLUMN `statusTransaksi`,
    ADD COLUMN `TotalPembayaran` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `id` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `status` ENUM('pesananDiterima', 'pesananDitolak', 'pesananDikirimKeEkspedisi', 'transitDiKotaTujuan', 'dikirimKeAlamatTujuan', 'diterima') NOT NULL,
    ADD COLUMN `updateAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    MODIFY `JenisPembayaran` ENUM('dana', 'cod', 'qris', 'ovo', 'gopay', 'linkaja', 'vitualAccountTransfer') NOT NULL DEFAULT 'cod';

-- AddForeignKey
ALTER TABLE `transaksi` ADD CONSTRAINT `transaksi_id_fkey` FOREIGN KEY (`id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
