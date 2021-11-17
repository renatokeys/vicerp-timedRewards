import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './pages/painel';
import { ChakraProvider, extendTheme } from '@chakra-ui/react';
import { StepsStyleConfig as Steps } from 'chakra-ui-steps';


const theme = extendTheme({
  components: {
    Steps,
  },
});
ReactDOM.render(
  <React.StrictMode>
    <ChakraProvider theme={theme}>
      <App />
    </ChakraProvider>
  </React.StrictMode>,
  document.getElementById('root')
);
