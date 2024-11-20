-- CreateTable
CREATE TABLE `Menu` (
    `idMenu` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL DEFAULT '',
    `price` INTEGER NOT NULL DEFAULT 0,
    `category` ENUM('food', 'drink', 'snack') NOT NULL DEFAULT 'food',
    `picture` VARCHAR(191) NOT NULL DEFAULT '',
    `description` VARCHAR(191) NULL DEFAULT '',

    UNIQUE INDEX `Menu_uuid_key`(`uuid`),
    PRIMARY KEY (`idMenu`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `idUser` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL DEFAULT '',
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL DEFAULT '',
    `profile_picture` VARCHAR(191) NOT NULL DEFAULT '',
    `role` ENUM('manager', 'cashier') NOT NULL DEFAULT 'cashier',

    UNIQUE INDEX `User_uuid_key`(`uuid`),
    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`idUser`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Order` (
    `idOrder` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `customer` VARCHAR(191) NOT NULL DEFAULT '',
    `table_number` VARCHAR(191) NOT NULL DEFAULT '',
    `total_price` INTEGER NOT NULL DEFAULT 0,
    `payment_method` ENUM('cash', 'qris') NOT NULL,
    `idUser` INTEGER NOT NULL DEFAULT 0,
    `status` ENUM('new', 'paid', 'done') NOT NULL,
    `userId` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `Order_uuid_key`(`uuid`),
    PRIMARY KEY (`idOrder`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OrderList` (
    `idOrderList` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `idOrder` INTEGER NOT NULL DEFAULT 0,
    `idMenu` INTEGER NOT NULL DEFAULT 0,
    `quantity` INTEGER NOT NULL DEFAULT 0,
    `note` VARCHAR(191) NULL DEFAULT '',
    `menuId` INTEGER NOT NULL DEFAULT 0,
    `orderId` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `OrderList_uuid_key`(`uuid`),
    PRIMARY KEY (`idOrderList`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`idUser`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_menuId_fkey` FOREIGN KEY (`menuId`) REFERENCES `Menu`(`idMenu`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderList` ADD CONSTRAINT `OrderList_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `Order`(`idOrder`) ON DELETE RESTRICT ON UPDATE CASCADE;
