import { createProdMockServer } from 'vite-plugin-mock'
import discoveryMock from './discovery'

export function setupProdMockServer() {
  createProdMockServer([...discoveryMock])
} 