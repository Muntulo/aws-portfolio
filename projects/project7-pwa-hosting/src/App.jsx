import './App.css'

function App() {
  return (
    <div className="app">
      <header className="header">
        <h1>Gustavo Guerra</h1>
        <h2>AWS Portfolio – Progressive Web App</h2>
        <p>This PWA is deployed with AWS Amplify • Add to Home Screen!</p>
      </header>

      <main className="main">
        <h2>Completed AWS Projects</h2>
        <div className="projects-grid">
          <div className="project">
            <h3>Static Website Hosting</h3>
            <p>S3 + CloudFront + Route 53 with OAC (this site!)</p>
            <a href="https://gmmguerra.com" target="_blank" rel="noopener">Live Demo</a>
          </div>
          <div className="project">
            <h3>WordPress on Lightsail</h3>
            <p>Managed WordPress blog with SSL and snapshots</p>
            <a href="https://blog.gmmguerra.com" target="_blank" rel="noopener">Live Demo</a>
          </div>
          <div className="project">
            <h3>EC2 Web Server</h3>
            <p>Custom Apache on Amazon Linux 2023 with Session Manager</p>
          </div>
          <div className="project">
            <h3>Scalable Web App</h3>
            <p>ALB + Auto Scaling Group with CPU scaling</p>
          </div>
          <div className="project">
            <h3>Multi-Tier Web App</h3>
            <p>VPC, ALB, private EC2 ASG, private RDS MySQL</p>
          </div>
          <div className="project">
            <h3>Serverless Static Website</h3>
            <p>S3 + CloudFront + CloudFront Functions</p>
            <a href="https://serverless.gmmguerra.com" target="_blank" rel="noopener">Live Demo</a>
          </div>
        </div>
      </main>

      <footer>
        <p>© 2025 Gustavo Guerra • Built with Vite + React PWA on AWS Amplify</p>
      </footer>
    </div>
  )
}

export default App