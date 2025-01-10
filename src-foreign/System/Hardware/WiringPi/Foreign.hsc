{-# LANGUAGE CPP, ForeignFunctionInterface #-}

module System.Hardware.WiringPi.Foreign
  ( valueToInt
  , intToValue
  , modeToInt
  , pudToInt
  , pwmModeToInt
  , intEdgeToInt
  , c_wiringPiSetupGpio
  , c_pinMode
  , c_pullUpDnControl
  , c_digitalRead
  , c_digitalWrite
  , c_pwmWrite
  , c_digitalWriteByte
  , c_pwmSetMode
  , c_pwmSetRange
  , c_pwmSetClock
  , c_wpiPinToGpio
  , c_physPinToGpio
  , mkWiringPiISRCallback
  , c_wiringPiISR
  , c_wiringPiI2CSetup
  , c_wiringPiI2CReadReg8
  , c_wiringPiI2CReadReg16
  , c_wiringPiI2CWriteReg8
  , c_wiringPiI2CWriteReg16
  , c_wiringPiI2CReadBlockData
  , c_wiringPiI2CWriteBlockData
  ) where

import Foreign.C.Types ( CInt(..), CUInt(..), CUChar(..) )
import Foreign.Ptr ( FunPtr , Ptr)
import System.Hardware.WiringPi.Enums

#include <wiringPi.h>

valueToInt :: Value -> CInt
valueToInt LOW  = #const LOW
valueToInt HIGH = #const HIGH

intToValue :: CInt -> Value
intToValue #const LOW
  = LOW
intToValue _          = HIGH

modeToInt :: Mode -> CInt
modeToInt INPUT      = #const INPUT
modeToInt OUTPUT     = #const OUTPUT
modeToInt PWM_OUTPUT = #const PWM_OUTPUT
modeToInt GPIO_CLOCK = #const GPIO_CLOCK

pudToInt :: Pud -> CInt
pudToInt PUD_OFF  = #const PUD_OFF
pudToInt PUD_DOWN = #const PUD_DOWN
pudToInt PUD_UP   = #const PUD_UP

pwmModeToInt :: PwmMode -> CInt
pwmModeToInt PWM_MODE_BAL = #const PWM_MODE_BAL
pwmModeToInt PWM_MODE_MS  = #const PWM_MODE_MS

intEdgeToInt :: IntEdge -> CInt
intEdgeToInt INT_EDGE_SETUP   = #const INT_EDGE_SETUP
intEdgeToInt INT_EDGE_FALLING = #const INT_EDGE_FALLING
intEdgeToInt INT_EDGE_RISING  = #const INT_EDGE_RISING
intEdgeToInt INT_EDGE_BOTH    = #const INT_EDGE_BOTH

foreign import ccall unsafe "wiringPi.h wiringPiSetupGpio"
    c_wiringPiSetupGpio :: IO CInt

foreign import ccall unsafe "wiringPi.h pinMode"
    c_pinMode :: CInt
              -> CInt
              -> IO ()

foreign import ccall unsafe "wiringPi.h pullUpDnControl"
    c_pullUpDnControl :: CInt
                      -> CInt
                      -> IO ()

foreign import ccall unsafe "wiringPi.h digitalRead"
    c_digitalRead :: CInt
                  -> IO CInt

foreign import ccall unsafe "wiringPi.h digitalWrite"
    c_digitalWrite :: CInt
                   -> CInt
                   -> IO ()

foreign import ccall unsafe "wiringPi.h pwmWrite"
    c_pwmWrite :: CInt
               -> CInt
               -> IO ()

foreign import ccall unsafe "wiringPi.h digitalWriteByte"
    c_digitalWriteByte :: CInt
                       -> IO ()

foreign import ccall unsafe "wiringPi.h pwmSetMode"
    c_pwmSetMode :: CInt
                 -> IO ()

foreign import ccall unsafe "wiringPi.h pwmSetRange"
    c_pwmSetRange :: CUInt
                  -> IO ()

foreign import ccall unsafe "wiringPi.h pwmSetClock"
    c_pwmSetClock :: CInt
                  -> IO ()

foreign import ccall unsafe "wiringPi.h wpiPinToGpio"
    c_wpiPinToGpio :: CInt
                   -> IO CInt

foreign import ccall unsafe "wiringPi.h physPinToGpio"
    c_physPinToGpio :: CInt
                    -> IO CInt

foreign import ccall "wrapper"
    mkWiringPiISRCallback :: IO ()
                          -> IO (FunPtr (IO ()))

foreign import ccall "wiringPi.h wiringPiISR"
    c_wiringPiISR :: CInt
                  -> CInt
                  -> FunPtr (IO ())
                  -> IO CInt

foreign import ccall "wiringPiI2C.h wiringPiI2CSetup"
    c_wiringPiI2CSetup :: CInt
                       -> IO CInt

foreign import ccall "wiringPiI2C.h wiringPiI2CReadReg8"
    c_wiringPiI2CReadReg8 :: CInt
                          -> CInt
                          -> IO CInt

foreign import ccall "wiringPiI2C.h wiringPiI2CReadReg16"
    c_wiringPiI2CReadReg16 :: CInt
                           -> CInt
                           -> IO CInt

foreign import ccall "wiringPiI2C.h wiringPiI2CWriteReg8"
    c_wiringPiI2CWriteReg8 :: CInt
                           -> CInt
                           -> CInt
                           -> IO CInt

foreign import ccall "wiringPiI2C.h wiringPiI2CWriteReg16"
    c_wiringPiI2CWriteReg16 :: CInt
                            -> CInt
                            -> CInt
                            -> IO CInt

foreign import ccall "wiringPiI2C.h wiringPiI2CReadBlockData"
    c_wiringPiI2CReadBlockData :: CInt
                               -> CInt
                               -> Ptr CUChar
                               -> CUChar
                               -> IO CInt

foreign import ccall "wiringPiI2C.h wiringPiI2CWriteBlockData"
    c_wiringPiI2CWriteBlockData :: CInt
                                -> CInt
                                -> Ptr CUChar
                                -> CUChar
                                -> IO CInt
