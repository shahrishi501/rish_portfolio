import React from 'react'
import { Link } from 'react-router-dom';
import {arrow} from '../assets/icons'


const InfoBox = ({text, link, btnText}) =>(
    <div className='info-box'>
       <p className='font-medium sm:text-xl text-center '>{text}</p> 
        <Link to={link} className='neo-brutalism-white neo-btn'>
            {btnText}
            <img src={arrow} className='w-4 h-4 object-contain'/>
        </Link>
    </div>
)

const renderContent ={
    1: (
        <h1 className='sm:text-xl sm:leading-snug text-center neo-brutalism-blue py-4 text-white mx-5'>
            Hi, I am<span className='font-semibold'>Rishi</span>👋
            <br/>
            A Third Year Computer Science Student
        </h1>
    ),
    2: (
        <InfoBox 
        text="Currently woking as Lead App Developer Intern at ThinkLocal.AI"
        link="/about"
        btnText="Learn More"
        />
    ),
    3: (
        <InfoBox 
        text="Currently woking as Lead App Developer Intern at ThinkLocal.AI"
        link="/about"
        btnText="Learn More"
        />
    ),
    4: (
        <InfoBox 
        text="Currently woking as Lead App Developer Intern at ThinkLocal.AI"
        link="/about"
        btnText="Learn More"
        />
    ),
}



const HomeInfo = ({currentStage}) => {
  return renderContent[currentStage] || null;
}

export default HomeInfo
