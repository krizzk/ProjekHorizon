// import { Category } from "@prisma/client";
import { NextFunction, Request,Response} from "express";
import Joi, { valid } from "joi";

const addDataSchema = Joi.object({
    namaBarang: Joi.string().required(),
    hargaBarang: Joi.number().min(0).required(),
    deskripsi: Joi.string().required(),
    banyakBarang: Joi.number().min(0).required(),
    alamatBarang: Joi.string().required(),
    fotoBarang: Joi.string().uri().optional()
})

const updateDataSchema = Joi.object({
    namaBarang: Joi.string().optional(),
    hargaBarang: Joi.number().min(0).optional(),
    deskripsi: Joi.string().optional(),
    banyakBarang: Joi.number().min(0).optional(),
    alamtBarang: Joi.string().optional(),
    fotoBarang: Joi.string().uri().optional()
})

export const verifyAddBarang = (request: Request, response: Response, next: NextFunction) => {
    const {error} = addDataSchema.validate(request.body,{abortEarly: false})
    
    if (error) {
        
        return response.status(400).json({
            status: false,
            massage: error.details.map(it => it.message).join()
        })
    }
    return next()
}

export const verifyUpdateBarang = (request: Request, response: Response, next: NextFunction) => {
    const {error} = updateDataSchema.validate(request.body,{abortEarly: false})
    
    if (error) {
        
        return response.status(400).json({
            status: false,
            massage: error.details.map(it => it.message).join()
        })
    }
    return next()
}