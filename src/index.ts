import express from 'express'
import cors from 'cors'
import barangR from './routers/barangR'
import userR from './routers/userR'

const PORT: number = 8000
const app = express()
app.use(cors())

app.use(`/barang`,barangR)
app.use(`/user`,userR)

app.listen(PORT,()=>{
    console.log(`[Server]: Server is running at http://localhost:${PORT}`);
    
})