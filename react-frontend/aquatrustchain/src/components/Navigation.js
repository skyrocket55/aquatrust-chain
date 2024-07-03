import React from 'react';
import Header from './Header';
import { NavLink } from 'react-router-dom';
import { faHandHoldingWater } from '@fortawesome/free-solid-svg-icons';

function Navigation() {
    return (
        <header>
            <nav className="navbar navbar-expand-lg navbar-dark bg-info mt-2">
                <div className="container-fluid">
                    <NavLink to="/" className="navbar-brand">
                        <div className='row'>
                            <div className='col'>
                                <Header title="AquaTrustChain" margin="ml-2" icon={faHandHoldingWater} size="xl" />
                            </div>
                        </div>
                    </NavLink>
                    <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span className="navbar-toggler-icon"></span>
                    </button>
                </div>
            </nav>
        </header>
    )
}

export default Navigation;