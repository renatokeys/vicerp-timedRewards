import { useState } from 'react';
import './App.css'
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";
import { useExitListener } from "../hooks/useExitListener";

debugData([
    {
        action: 'setVisible',
        data: true,
    }
])

const App = () => {
    const [isVisible, setIsVisible] = useState(false)

    useNuiEvent('setVisible', (data) => {
        setIsVisible(data)
    })

    useExitListener(setIsVisible)

    return (
        <div className="nui-wrapper">
            <div className='popup-thing' style={{ visibility: isVisible ? 'visible' : 'hidden' }}>
            </div>
        </div>
    );
}

export default App;
