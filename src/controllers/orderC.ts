import { Request,Response } from "express"; 
import { PrismaClient } from "@prisma/client";
import { v4 as uuidv4 } from "uuid";
import { BASE_URL } from "../global";
import fs from "fs"

const prisma = new PrismaClient({errorFormat: "pretty" })

//Get all Barang
export const getAllOrder= async (request:Request, response:Response) =>{
    try {
        const {search} = request.query
        const allOrder = await prisma.order.findMany({
            where: { id: {}}
        })
        //Output
        return response.json({
            status:true,
            data: allOrder,
            massage:`order has retrived`
        }).status(200)
    } catch (error) {
        return response
        .json({
            status:false,
            massage: `There is an error. ${error}`
        })
        .status(400)
    }
}

export const createOrder = async (request: Request, response: Response) => {
    try {
        const { JenisPembayaran,TotalPembayaran, status, order_list } = request.body
        const user = request.body.user
        const uuid = uuidv4()

        let total_price = 0
        for (let index = 0; index < order_list.length; index++) {
            const { menuId } = order_list[index]
            const detailMenu = await prisma.barang.findFirst({
                where: {
                    idBarang: menuId
                }
            })
            if (!detailMenu) return response
            .status(200).json({ status: false, message: `Menu with id ${menuId} is not found` })
            total_price += (detailMenu.hargaBarang *  order_list[index].quantity)
        }

        /** process to save new order */
        const newOrder = await prisma.order.create({
            data: { uuid,TotalPembayaran, JenisPembayaran, status, user: user.id }
        })
 
        /** loop details of Order to save in database */
        for (let index = 0; index < order_list.length; index++) {
            const uuid = uuidv4()
            const { menuId, quantity, note } = order_list[index]
            await prisma.order_list.create({
                data: {
                    uuid, idOrder: newOrder.id, IdBarang: Number(menuId), jumlahBarang: Number(quantity), note
                }
            })
        }
        return response.json({
            status: true,
            data: newOrder,
            message: `New Order has created`
        }).status(200)
    } catch (error) {
        return response
            .json({
                status: false,
                message: `There is an error. ${error}`
            })
            .status(400)
    }
 }
 
 
 export const updateStatusOrder = async (request: Request, response: Response) => {
    try {
        /** get id of order's id that sent in parameter of URL */
        const { id } = request.params
        /** get requested data (data has been sent from request) */
        const { status } = request.body
        const user = request.body.user
 
 
        /** make sure that data is exists in database */
        const findOrder = await prisma.order.findFirst({ where: { id: Number(id) } })
        if (!findOrder) return response
            .status(200)
            .json({ status: false, message: `Order is not found` })
 
 
        /** process to update menu's data */
        const updatedStatus = await prisma.order.update({
            data: {
                status: status || findOrder.status,
                iduser: user.id ? user.id : findOrder.iduser
            },
            where: { id: Number(id) }
        })
 
 
        return response.json({
            status: true,
            data: updatedStatus,
            message: `Order has updated`
        }).status(200)
    } catch (error) {
        return response
            .json({
                status: false,
                message: `There is an error. ${error}`
            })
            .status(400)
    }
 }
 
 export const deleteOrder = async (request: Request, response: Response) => {
    try {
        /** get id of order's id that sent in parameter of URL */
        const { id } = request.params
 
 
        /** make sure that data is exists in database */
        const findOrder = await prisma.order.findFirst({ where: { id: Number(id) } })
        if (!findOrder) return response
            .status(200)
            .json({ status: false, message: `Order is not found` })
 
 
        /** process to delete details of order */
        let deleteOrderList = await prisma.order_list.deleteMany({ where: { idOrder: Number(id) } })
        /** process to delete of Order */
        let deleteOrder = await prisma.order.delete({ where: { id: Number(id) } })
 
 
        return response.json({
            status: true,
            data: deleteOrder,
            message: `Order has deleted`
        }).status(200)
    } catch (error) {
        return response
            .json({
                status: false,
                message: `There is an error. ${error}`
            })
            .status(400)
    }
 }
 
 