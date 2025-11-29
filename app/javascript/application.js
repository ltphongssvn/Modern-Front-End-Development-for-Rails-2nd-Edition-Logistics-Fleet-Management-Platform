// app/javascript/application.js
import "@hotwired/turbo-rails"
import "./controllers"
import React from 'react'
import ReactDOM from 'react-dom/client'
import Dashboard from './components/Dashboard'

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root')
  if (root) {
    ReactDOM.createRoot(root).render(<Dashboard />)
  }
})
