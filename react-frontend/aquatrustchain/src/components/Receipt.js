import React from 'react';
import { faReceipt, faCubes, faBuildingNgo, faHandHoldingWater, faBusinessTime } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

import Header from './Header';

function Receipt(props) {
    return (
      <div className='table-responsive mt-3 text-center justify-content-center'>
        <Header title="Donation Details" margin="ml-2" icon={faReceipt} size="xs"/>
        <table className='table table-hover'>
            <thead>
                <tr>
                    <th scope='col'><FontAwesomeIcon icon={faCubes} size="sm"/> Block #</th>
                    <th scope='col'><FontAwesomeIcon icon={faBuildingNgo} size="sm"/> Recipient</th>
                    <th scope='col'><FontAwesomeIcon icon={faHandHoldingWater} size="sm"/> Amount</th>
                    <th scope='col'><FontAwesomeIcon icon={faBusinessTime} size="sm"/> Transaction Timestamp</th>
                </tr>
            </thead>
            <tbody>
            {props && (
            <>    
                <tr>
                    <td width='25%'>{props.receiptDetails.block}</td>
                    <td width='25%'>{props.receiptDetails.recipient}</td>
                    <td width='25%'>{props.receiptDetails.amount} Liters</td>
                    <td width='25%'>{props.receiptDetails.donationTimestamp}</td>
                </tr>
            </>
            )}
            </tbody>
        </table>
      </div>
    );
  }

export default Receipt;