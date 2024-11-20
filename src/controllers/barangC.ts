import { Request,Response } from "express"; 
import { PrismaClient } from "@prisma/client";
import { v4 as uuidv4 } from "uuid";
import { BASE_URL } from "../global";
import fs from "fs"

const prisma = new PrismaClient({errorFormat: "pretty" })

//Get all Barang
export const getAllBarang = async (request:Request, response:Response) =>{
    try {
        const {search} = request.query
        const allBarang = await prisma.barang.findMany({
            where: { namaBarang : {contains: search?.toString() || ""}}
        })
        //Output
        return response.json({
            status:true,
            data: allBarang,
            massage:`Barang has retrived`
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

export const createBarang = async (request: Request, response: Response) => {
    try {
        const { namaBarang, hargaBarang, deskripsi, banyakBarang, alamatBarang } = request.body
        const uuid = uuidv4()

        const newBarang = await prisma.barang.create({
            data: { uuid, namaBarang, hargaBarang: Number(hargaBarang), deskripsi  , banyakBarang: Number(banyakBarang), alamatBarang }
        })
        //Output
        return response.json({
            status: true,
            data: newBarang,
            message: `New barang has created`
        }).status(200)

    } catch (error) {
        return response.json({
            status: false,
            message: `There is an error. ${error}`
        })
        .status(400)
    }
}
export const updateBarang = async (request:Request, response:Response) =>{
    try {
        const {id} = request.params
        const {namaBarang, hargaBarang, deskripsi, banyakBarang, alamatBarang} = request.body

        const findBarang = await prisma.barang.findFirst({where: {idBarang: Number(id)}})
        if (!findBarang)return response 
        .status(200)
        .json({ status: false, massage:`IdBarang: ${id} is not found`})

        const updateBarang = await prisma.barang.update ({
            data:{
                namaBarang: namaBarang || findBarang.namaBarang,
                hargaBarang: hargaBarang ? Number(hargaBarang) : findBarang.hargaBarang,
                deskripsi: deskripsi || findBarang.deskripsi,
                banyakBarang: banyakBarang || findBarang.banyakBarang,
                alamatBarang: alamatBarang || findBarang.alamatBarang
            },
            where: {idBarang: Number(id)}
        })
        return response.json({
            status: true,
            data:updateBarang,
            massage: `Barang has been updated`
        }).status(200)

    } catch (error) {
        return response.json({
            status: false,
            massage:`There is an error. ${error}`
        })
        .status(400)
    }
}
export const deleteBarang = async (request:Request, response:Response) =>{
    try {
        const {id} = request.params
        const findBarang = await prisma.barang.findFirst({where: {idBarang: Number(id)}})
        if (!findBarang)return response 
        .status(200)
        .json({ status: false, massage:`IdBarang:${id} is not found`})

        const result = await prisma.barang.delete({
            where: {idBarang: Number(request.params.id)}
        })
        return response.json({
            status:true,
            data:findBarang,
            massage:`Menu with id ${id} has been deleted`
        }).status(200)
    } catch (error) {
        return response.json({
            status: false,
            massage:`There is an error. ${error}`
            })
            .status(400)
    }
}

export const changePicture = async (request:Request, response:Response)=>{
    try {
        const {id} = request.params
        const findBarang = await prisma.barang.findFirst({where: {idBarang: Number(id)}})
        if (!findBarang)return response 
        .status(200).json({ status: false, massage:`Menu with id ${id} is not found`})

        /** default value  filename of  saved data*/
        let filename = findBarang.fotoBarang
        if (request.file) {
            /**update filename by new uploaded picture */
            filename = request.file.filename
            /**check the old picture in the folder */
            let path = `${BASE_URL}/../public/picture_barang/${findBarang.fotoBarang}`
            let exist = fs.existsSync(path)
            /**delet the old exist picture if reupload new file  */
            if (exist && findBarang.fotoBarang !==``) fs.unlinkSync(path)
        }

        /**process to update picture  in database */
        const  updatePicture = await prisma.barang.update ({
            data:{fotoBarang:filename},
            where: {idBarang: Number(id)}
            })
            return response.json({
                status: true,
                data:updatePicture,
                message:`picture has change`
            }).status(200)

    } catch (error) {
        return response.json({
            status: false,
            massage:`There is an error. ${error}`
            }).status(400)
    }                   
}