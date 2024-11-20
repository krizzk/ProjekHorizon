import express from "express";
import { authentification, changeProfile, createuser, createuserpelanggan, deleteuser, getAlluser, updateuser } from "../controllers/userC";
import { verifyAddAdmin, verifyAuthentification, verifyRegister, verifyUpdateAdmin } from "../middlewares/userValidation";
import uploadFileUser from "../middlewares/userUpload"
import { verifyRole, verifyToken } from "../middlewares/authorization";

const app = express()
app.use(express.json())

app.get(`/`,[verifyToken,verifyRole(["admin"])],getAlluser)
app.post(`/create`,[verifyToken,verifyRole(["admin"]),verifyAddAdmin],createuser);
app.put(`/update/:id`,[verifyToken,verifyRole(["admin"]),verifyUpdateAdmin],updateuser)
app.put(`/pic/:id`,[verifyToken,verifyRole(["admin","pelanggan"]),uploadFileUser.single("picture")],changeProfile)
app.delete(`/delete/:id`,[verifyToken,verifyRole(["admin"])],deleteuser)

app.post(`/register`,[verifyRegister],createuserpelanggan);
app.post(`/login`,[verifyAuthentification],authentification)

export default app;