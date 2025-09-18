# DanceStudio - Digital Dance Community Platform

A blockchain-based platform for dance classes, practice logs, and dancer community rewards built on the Stacks blockchain using Clarity smart contracts.

[![Built with Stacks](https://img.shields.io/badge/Built_with-Stacks-purple.svg)](https://www.stacks.co/)
[![Smart Contract](https://img.shields.io/badge/Smart_Contract-Clarity-orange.svg)](https://clarity-lang.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

DanceStudio creates a decentralized community where dancers can log practice sessions, create and teach dance classes, write reviews, and earn DRT (DanceStudio Rhythm Token) rewards for their participation. The platform emphasizes rhythm, coordination, and the flowing nature of dance through its reward system.

## Key Features

### Dance Practice Tracking
- **Practice Session Logging**: Record dance sessions with detailed metrics
- **Rhythm & Coordination Scoring**: 1-5 scale tracking for dance fundamentals
- **Energy Level Monitoring**: Track workout intensity and engagement
- **Music Tempo Integration**: BPM tracking for different dance styles
- **Flow State Recognition**: Special rewards for achieving optimal dance flow

### Class Creation & Teaching
- **Dance Class Management**: Create classes with style, difficulty, and duration settings
- **Student Capacity Control**: Set maximum class sizes for optimal learning
- **BPM-Based Organization**: Music tempo specifications for class planning
- **Teaching Statistics**: Track classes taught and teaching effectiveness
- **Flow Rating System**: Community-driven class quality assessment

### Community Engagement
- **Class Reviews**: Rate and review dance classes with detailed feedback
- **Teaching Style Assessment**: Categorize instructors by teaching approach
- **Beat Voting**: Community appreciation system for helpful reviews
- **Milestone Achievements**: Recognition for consistent practice and teaching

### Dancer Progression
- **Style Specialization**: Track preferred dance styles and expertise
- **Practice Statistics**: Comprehensive tracking of total practice time
- **Rhythm Score Development**: Progressive skill measurement system
- **Achievement Milestones**: Unlock rewards for dedication and consistency

## Token Economy (DRT - DanceStudio Rhythm Token)

### Token Details
- **Name**: DanceStudio Rhythm Token
- **Symbol**: DRT
- **Decimals**: 6
- **Total Supply**: 55,000 DRT
- **Blockchain**: Stacks

### Reward Structure
![DanceStudio Reward Structure](images/dancestudio-reward-structure.png)

## Smart Contract Architecture

### Core Data Structures

#### Dancer Profile
![Dancer Profile Structure](images/dancer-profile-structure.png)

#### Dance Class
![Dance Class Structure](images/dance-class-structure.png)

#### Practice Log
![Practice Log Structure](images/practice-log-structure.png)

#### Class Review System
![Class Review Structure](images/class-review-structure.png)

### Dance Style Categories

The platform supports multiple dance styles with specialized tracking:

- **Ballet**: Classical technique with emphasis on precision and grace
- **Hip Hop**: Street dance with focus on rhythm and personal expression
- **Salsa**: Partner dance emphasizing coordination and musicality
- **Jazz**: Contemporary style combining technique with creative expression
- **Contemporary**: Modern movement emphasizing flow and emotional expression

## Getting Started

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet) - Stacks smart contract development tool
- [Stacks Wallet](https://www.hiro.so/wallet) - For blockchain interactions
- Basic understanding of dance terminology
- Knowledge of Clarity smart contracts

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/dancestudio-platform.git
cd dancestudio-platform
```

2. **Install Clarinet**
```bash
curl -L https://github.com/hirosystems/clarinet/releases/download/v1.8.0/clarinet-linux-x64.tar.gz | tar xz
mv clarinet /usr/local/bin/
```

3. **Initialize project**
```bash
clarinet new dancestudio-project
cd dancestudio-project
# Copy contract to contracts/dancestudio.clar
```

### Deployment

1. **Test the contract**
```bash
clarinet test
```

2. **Deploy to devnet**
```bash
clarinet integrate
```

3. **Deploy to testnet/mainnet**
```bash
clarinet deployment apply -p testnet
```

## Usage Examples

### Create a Dance Class
![Create Dance Class Function](images/create-dance-class-function.png)

### Log Practice Session
![Log Practice Function](images/log-practice-function.png)

### Write Class Review
![Write Review Function](images/write-review-function.png)

### Vote on Review Beat
![Vote Beat Function](images/vote-beat-function.png)

### Update Dance Style
![Update Dance Style Function](images/update-dance-style-function.png)

### Claim Achievement Milestone
![Claim Milestone Function](images/claim-milestone-function.png)

## Core Functions

### Class Management
- `create-dance-class(...)` - Create new dance classes for teaching
- `get-dance-class(class-id)` - Retrieve class details and statistics
- `write-review(...)` - Submit feedback and ratings for classes
- `vote-beat(...)` - Appreciate helpful community reviews

### Practice Tracking
- `log-practice(...)` - Record dance practice sessions with metrics
- `get-practice-log(practice-id)` - View individual practice session details
- `update-dance-style(style)` - Update preferred dance specialization

### Community Features
- `claim-milestone(milestone)` - Unlock achievement rewards
- `update-username(username)` - Update dancer profile information
- `get-dancer-profile(dancer)` - View dancer statistics and progress

### Token Operations
- `get-balance(user)` - Check DRT token balance
- `get-name()`, `get-symbol()`, `get-decimals()` - Token metadata

## Dance Metrics & Scoring

### Practice Assessment Scales
- **Coordination**: 1-5 scale measuring movement precision and control
- **Rhythm Feel**: 1-5 scale assessing musicality and timing
- **Energy Level**: 1-5 scale tracking workout intensity and engagement
- **Flow State**: Boolean indicator for achieving optimal dance experience

### Class Quality Indicators
- **Flow Rating**: Community-averaged assessment of class effectiveness
- **Practice Count**: Number of students who achieved flow during class
- **Teaching Style**: Community categorization of instruction approach
- **Beat Votes**: Community appreciation for helpful class reviews

### Music Integration
- **BPM Range**: 60-180 beats per minute for class specification
- **Tempo Tracking**: 50-200 BPM range for practice session logging
- **Style-Specific Tempos**: Appropriate BPM ranges for different dance styles

## Dancer Progression System

### Skill Development
- **Rhythm Score**: Progressive 1-5 scale based on consistent practice quality
- **Total Minutes**: Cumulative practice time tracking for dedication measurement
- **Practice Consistency**: Regular logging rewards and milestone achievements
- **Style Mastery**: Specialized expertise development in chosen dance forms

### Achievement Milestones
![Achievement Milestones](images/achievement-milestones.png)

### Community Recognition
- **Teaching Contributions**: Recognition for creating and leading dance classes
- **Review Quality**: Beat voting system for helpful community feedback
- **Practice Leadership**: Inspiring others through consistent dedication
- **Flow Achievement**: Special recognition for dancers who regularly achieve flow state

## Access Controls & Requirements

### Class Creation
- Open to all community members
- Duration and student capacity validation
- BPM range enforcement for realistic music tempo

### Practice Logging
- Personal practice sessions only
- Metric validation for realistic scoring
- Flow state bonus rewards for quality sessions

### Review System
- Cannot review own classes
- One review per class per dancer
- Community beat voting for review appreciation

## Security Features

### Input Validation
- String length limits for all text fields
- Numeric range validation for all scoring metrics
- BPM validation within realistic ranges for dance music
- Duration validation for practice sessions and classes

### Access Control
- Self-review prevention for class feedback
- Practice session ownership validation
- Milestone achievement verification
- Profile update restrictions to account owners

### Anti-Gaming Measures
- Flow state requirements for full practice rewards
- Reduced rewards for non-flowing practice sessions
- Milestone verification based on actual achievements
- Community validation through beat voting system

### Error Handling
![DanceStudio Error Codes](images/dancestudio-error-codes.png)

## Community Features

### Dance Style Diversity
- Multiple dance genres supported with specialized tracking
- Style-specific practice logging and class creation
- Community-driven expansion of supported dance forms
- Cultural appreciation and inclusive dance community

### Social Learning
- Class review system for sharing learning experiences
- Teaching feedback to help instructors improve
- Beat voting to highlight valuable community contributions
- Milestone sharing to inspire consistent practice

### Flow State Emphasis
- Special recognition for achieving optimal dance experience
- Bonus rewards for flow state achievement during practice
- Flow rating system for classes that consistently produce flow states
- Community understanding of dance as a mindful, flowing practice

## Development Roadmap

### Phase 1: Core Dance Platform
- Smart contract deployment with dance-specific functionality
- Practice logging and class creation systems
- Community review and feedback mechanisms
- Token reward distribution for dance activities

### Phase 2: Enhanced Community Features
- Video integration for dance tutorials and reviews
- Partner dance tracking and coordination features
- Dance battle and competition organization
- Advanced choreography sharing and collaboration tools

### Phase 3: Ecosystem Expansion
- Mobile app for real-time practice logging
- Integration with music streaming services
- Dance studio partnership program
- Professional instructor certification system

### Phase 4: Innovation Hub
- Motion capture integration for technique analysis
- AI-powered dance improvement suggestions
- Virtual reality dance experiences
- Global dance community events and competitions

## Health & Wellness Focus

### Balanced Approach to Dance
- Emphasis on enjoyment and personal expression over perfection
- Flow state recognition promoting mindful dance practice
- Energy level tracking for appropriate workout intensity
- Community support for dancers at all skill levels

### Inclusive Community Standards
- Welcoming environment for all dance styles and skill levels
- Positive feedback culture through review and beat voting systems
- Recognition of diverse dance traditions and expressions
- Support for both recreational and serious dance practitioners

## Testing

```bash
# Run comprehensive tests
clarinet test

# Test specific dance modules
clarinet test tests/dance_class_test.ts
clarinet test tests/practice_logging_test.ts
clarinet test tests/community_features_test.ts
clarinet test tests/milestone_system_test.ts

# Validate contract
clarinet check
```

## API Reference

### Read-Only Functions
- `get-dancer-profile(dancer)` - Dancer statistics and preferences
- `get-dance-class(class-id)` - Class details and community ratings
- `get-practice-log(practice-id)` - Individual practice session data
- `get-class-review(class-id, reviewer)` - Review content and community feedback
- `get-milestone(dancer, milestone)` - Achievement status and dates

### Write Functions
- Class creation and management functions
- Practice session logging and tracking functions
- Community review and feedback functions
- Profile and preference management functions
- Achievement milestone claiming functions

## Contributing

We welcome contributions from dancers, choreographers, dance instructors, and developers!

### Development Guidelines
1. Fork the repository and create feature branches
2. Write comprehensive tests for dance-specific scenarios
3. Follow dance community standards and inclusive practices
4. Update documentation with dance terminology and context
5. Submit pull requests with detailed dance use case descriptions

### Contribution Areas
- Dance-specific smart contract enhancements
- Mobile dance tracking application development
- Video integration and dance tutorial features
- Community feedback and review system improvements
- Dance style expansion and cultural representation

## Community Standards

### Inclusive Dance Environment
- Respectful interaction between all community members regardless of skill level
- Appreciation for diverse dance styles and cultural expressions
- Constructive feedback focused on growth and improvement
- Support for both recreational and professional dance goals

### Health and Safety
- Emphasis on personal limits and injury prevention
- Balanced approach to practice intensity and frequency
- Mental health awareness in dance and performance contexts
- Community support for sustainable dance practice habits

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Community

- **Documentation**: [docs.dancestudio.io](https://docs.dancestudio.io)
- **Discord**: [Join our dance community](https://discord.gg/dancestudio)
- **Twitter**: [@DanceStudioPlatform](https://twitter.com/dancestudioplatform)
- **Email**: support@dancestudio.io

## Acknowledgments

- Built on Stacks blockchain infrastructure
- Powered by Clarity smart contract language
- Inspired by the global dance community
- Dedicated to promoting dance as accessible art and exercise
- Community-driven development with dancer feedback

---

**Moving together through rhythm, flow, and community**
