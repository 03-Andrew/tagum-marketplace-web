const express = require('express');
const {getAnalytics, getMonthlyTotalSales, getWeeklyTotalSales, getYearlyTotalSales} = require('../controllers/analyticsController');
const { checkPermissions,verifyToken,extractToken } = require('../middleware/authMiddleware.js');

const router = express.Router();

router.get('/',extractToken,verifyToken,checkPermissions,getAnalytics);
router.get('/monthly',extractToken,verifyToken,checkPermissions,getMonthlyTotalSales);
router.get('/weekly',extractToken,verifyToken,checkPermissions,getWeeklyTotalSales);
router.get('/yearly',extractToken,verifyToken,checkPermissions,getYearlyTotalSales);
module.exports = router;