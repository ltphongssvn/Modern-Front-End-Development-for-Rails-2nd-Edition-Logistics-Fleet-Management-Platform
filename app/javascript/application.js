// app/javascript/application.js
import "@hotwired/turbo-rails"
import "./controllers"
import * as React from 'react'
import { createRoot } from 'react-dom/client'
import Dashboard from './components/Dashboard'

document.addEventListener('turbo:load', () => {
  const root = document.getElementById('root')
  if (root && !root.dataset.reactApp) {
    root.dataset.reactApp = 'true'
    createRoot(root).render(React.createElement(Dashboard))
  }
})
