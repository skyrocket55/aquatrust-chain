import './App.css';
import Dashboard from './components/Dashboard';
import Navigation from './components/Navigation';
import React from 'react';
import { BrowserRouter as Router, 
  Routes, 
  Route,
  Navigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.min.js';

function App() {
  return (
    <div className='container-fluid'>
      <Router>
        <Navigation/>
        <Routes>
          <Route path="/" element={<Dashboard/>} />
          {/* Invalid Path Redirect to Dashboard */}
          <Route path="*" element={<Navigate to="/"/>} />
        </Routes>
      </Router>
    </div>
  );
}

export default App;