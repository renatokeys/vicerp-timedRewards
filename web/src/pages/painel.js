import { useState, useEffect } from 'react';
import './App.css'
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";
import { useExitListener } from "../hooks/useExitListener";
import { Center, Text, Flex, Image, Button } from "@chakra-ui/react";
import { GiLockedChest, GiOpenChest } from 'react-icons/gi';
import { Step, Steps, useSteps } from 'chakra-ui-steps';
import { fetchNui } from '../utils/fetchNui'

const steps = [
    { label: <Text color='white' fontWeight={800}>4 HORAS</Text> },
    { label: <Text color='white' fontWeight={800}>8 HORAS</Text> },
    { label: <Text color='white' fontWeight={800}>12 HORAS</Text> },
    { label: <Text color='white' fontWeight={800}>16 HORAS</Text> },
    { label: <Text color='white' fontWeight={800}>20 HORAS</Text> }
];


debugData([
    {
        action: 'setVisible',
        data: true,
    }
])

const App = () => {
    const [prize, setPrize] = useState(0);
    const [curStep, setCurStep] = useState(0);
    const { nextStep, prevStep, setStep, reset, activeStep } = useSteps({
        initialStep: 0,
    });
    const [show, setShow] = useState(false);

    const [isVisible, setIsVisible] = useState(false)

    useNuiEvent('setVisible', (data) => {
        setIsVisible(data)
    })

    useExitListener(setIsVisible)

    const getData = async () => {
        fetchNui('getData').then(data => {
            setCurStep(data.rewardStatus)
            setPrize(data.prize)
            if (data.prize > 0) {

                setStep(data.rewardStatus - 1)
            }
            else {
                setStep(data.rewardStatus)
            }
        })
    }

    useEffect(() => {
        getData()
    }, [isVisible])

    const handleGetRewards = () => {
        fetchNui('getRewards').then(data => {
            setShow(true)
            setStep(curStep)
        })
    }
    return (
        <div className="nui-wrapper">
            <div className='popup-thing' style={{ visibility: isVisible ? 'visible' : 'hidden' }}>
                <Center w='100%' minH='100vh'>
                    <Flex w='1100px' h='400px' bg='linear-gradient(56deg, rgba(36,35,42,1) 33%, rgba(57,38,53,1) 100%)' flexDirection='column' overflow='hidden' rounded='xl' boxShadow='dark-lg'>
                        <Flex justifyContent='flex-end' px={8} pt={8}>
                            <Flex flexDirection='column'>
                                <Text textTransform='uppercase' alignSelf='start' color='white' fontWeight='700'>Suas Coins</Text>
                                <Text align='center' fontWeight={900} color='green.500'>2.573</Text>
                            </Flex>
                        </Flex>

                        <Flex p={8}>
                            <Center flexDirection='column' w='30%' h='100%'>
                                <Center>
                                    <Image src='/timed/chest.png' w='200px' alt='' />
                                </Center>
                                <Button colorScheme='teal' onClick={handleGetRewards}>Receba sua Recompensa</Button>
                            </Center>
                            <Flex flex='1'>
                                <Center flexDirection='column' w='100%' color='white'>
                                    <Text textTransform='uppercase' fontWeight={900} fontSize='3.5rem' lineHeight='1'>Jogue e ganhe!</Text>
                                    <Text fontSize='2rem' fontWeight='700'>Reset todos os dias as 06:00</Text>
                                    {prize > 0 && show && <Text fontWeight={700} textTransform='uppercase' p={4}>Você ganhou <span style={{ color: 'yellow' }}>{prize} Coins</span></Text>}
                                    {prize === 0 && show && <Text fontWeight={700} textTransform='uppercase' p={4}>Não há recompensas para resgatar</Text>}
                                    <Flex pt={10}>
                                        <Steps activeStep={activeStep} checkIcon={GiOpenChest}>
                                            {steps.map(({ label, content }) => (
                                                <Step label={label} key={label} icon={GiLockedChest} />
                                            ))}
                                        </Steps>
                                    </Flex>

                                </Center>

                            </Flex>

                        </Flex>
                        <Flex position='relative' left='850px' bottom='25px'>
                            <Text color='white'>use /vip para usar suas moedas</Text>
                        </Flex>
                    </Flex>

                </Center >
            </div>
        </div>
    );
}

export default App;
