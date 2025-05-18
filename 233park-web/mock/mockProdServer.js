import { createProdMockServer } from 'vite-plugin-mock/es/createProdMockServer'
import discoveryMock from './discovery'

export function setupProdMockServer() {
  createProdMockServer([...discoveryMock])
} 