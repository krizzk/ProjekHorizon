import { NextFunction,Request,Response } from "express";
import Joi from "joi"

const updateDataSchema = Joi.object({
    nama: Joi.string().optional(),
    kontak: Joi.number().optional(),
    alamat: Joi.string().optional(),
    username: Joi.string().optional(),
    role: Joi.string().optional(),
    email: Joi.string().optional(),
    password: Joi.string().min(3).alphanum().optional(),
    picture: Joi.allow().optional(),
});

const authSchema = Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string().min(3).alphanum().required()
})

const addDataSchemaAdmin = Joi.object({
    nama: Joi.string().required(),
    kontak: Joi.number().required(),
    alamat: Joi.string().required(),
    username: Joi.string().required(),
    role: Joi.string().valid("admin").required(),
    email: Joi.string().required(),
    password: Joi.string().min(3).alphanum().required(),
    picture: Joi.allow().optional(),
});


  export const verifyUpdateAdmin = (request: Request, response: Response, next: NextFunction) => {
    const {error} = updateDataSchema.validate(request.body,{abortEarly: false})
    
    if (error) {
        
        return response.status(400).json({
            status: false,
            massage: error.details.map(it => it.message).join()
        })
    }
    return next()
}

    export const verifyAuthentification = (
    request: Request,
    response:Response,
    next: NextFunction
) =>{
    const {error} = authSchema.validate(request.body,{abortEarly:false})

    if (error){
        return response.status(400).json({
            status:false,
            message: error.details.map((it)=> it.message).join()
        })
    }
    return next();
}

export const verifyAddAdmin = (
    request: Request,
    response: Response,
    next: NextFunction
  ) => {
    const { error } = addDataSchemaAdmin.validate(request.body, { abortEarly: false });
    if (error) {
      return response.status(400).json({
        status: false,
        message: error.details.map((it) => it.message).join(),
      });
    }
    return next();
  };

  const registerDataSchema = Joi.object({
    nama: Joi.string().required(),
    kontak: Joi.number().required(),
    alamat: Joi.string().required(),
    username: Joi.string().required(),
    role: Joi.string().valid("pelanggan").required(),
    email: Joi.string().required(),
    password: Joi.string().min(3).alphanum().required(),
    picture: Joi.allow().optional(),
});

export const verifyRegister = (
    request: Request,
    response: Response,
    next: NextFunction
  ) => {
    const { error } = registerDataSchema.validate(request.body, { abortEarly: false });
    if (error) {
      return response.status(400).json({
        status: false,
        message: error.details.map((it) => it.message).join(),
      });
    }
    return next();
  };