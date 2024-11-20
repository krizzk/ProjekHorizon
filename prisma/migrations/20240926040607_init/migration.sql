-- AlterTable
ALTER TABLE `barang` MODIFY `BeratBarang` INTEGER NOT NULL DEFAULT 0,
    MODIFY `BanyakBarang` INTEGER NOT NULL DEFAULT 0,
    MODIFY `HargaBarang` INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `detailtransaksi` MODIFY `IdBarang` INTEGER NOT NULL DEFAULT 0,
    MODIFY `TotalBarang` INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `pelanggan` MODIFY `TanggalLahir` INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `transaksi` MODIFY `ekspedisi` VARCHAR(255) NOT NULL DEFAULT '',
    MODIFY `statusTransaksi` VARCHAR(255) NOT NULL DEFAULT '',
    MODIFY `TanggalTransaksi` VARCHAR(255) NOT NULL DEFAULT '';
