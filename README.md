### Hexlet tests and linter status:
[![Actions Status](https://github.com/kalash-job/rails-project-66/workflows/hexlet-check/badge.svg)](https://github.com/kalash-job/rails-project-66/actions)
[![Actions Status](https://github.com/kalash-job/rails-project-66/workflows/main/badge.svg)](https://github.com/kalash-job/rails-project-66/actions)

<h1>Project "Repository Quality Analyzer".</h1>
<p>This project is available on railway by the link <a href="https://githubqualityanalyzer-production.up.railway.app/">Repository Quality Analyzer</a></p>


<h2>About the project:</h2>
<p>This is the fourth project from the course Ruby on Rails developer by Hexlet.</p>
<p>The project aims to create a web application with async code, integrated with github.com.</p>
<p>Repository owners can use this application to control the quality of their code bases throw regular checking by linters and get reports about offenses for correction.</p>
<p>Currently, the application allows you to check projects in Javascript or Ruby languages.</p>
<p>If necessary, you can easily extend a list of using linters so the app will check projects in other languages.</p>

<p><b>Users without login</b> (visitors) can only see a homepage and use Github authentication for sign-in or signup.</p>
<p><b>Authenticated users</b> additionally can add their repositories for checking and run checks for any of their repositories. </p>
<p>They also can look at all checks results and get email messages about errors during checks or offenses for their repositories after the checks.</p>
<p>Project error tracking is performed using Rollbar.</p>

<h3>The main technologies used during project development were the following:</h3>
<ul>
<li>Ruby 3.2.2.</li>
<li>Ruby on Rails 7.</li>
<li>gem aasm.</li>
<li>gem dry-container.</li>
<li>gem minitest-power_assert.</li>
<li>gem octokit.</li>
<li>gem omniauth-github.</li>
<li>gem pundit.</li>
<li>gem rails-i18n.</li>
<li>gem redis.</li>
<li>gem sidekiq.</li>
<li>gem simple_form.</li>
<li>gem slim-rails.</li>
<li>gem rubocop-rails.</li>
<li>Github webhooks.</li>
</ul>

<h2>Common instructions for local deployment:</h2>
<p>After <b>git clone</b> and <b>bundle install</b> commands you should execute the <b>make setup</b> command.</p>
<p>These actions will create a database structure locally and prepare the application for use.</p>
<p>You can also run tests with the <b>make tests</b> command. It will run a check by tests of controllers and system tests.</p>
<p>Then you should to fill .env file with your values. You need to use ngrok for correct work of webhooks locally and add URL from ngrok into BASE_URL and APP_HOST fields of .env file.</p>
<p>For running ngrok you can use the command <b>ngrok http 3000</b></p>
<p>For running Redis you can use the command <b>sudo systemctl start redis-server</b></p>
<p>So after that, you can use the command <b>foreman start</b> or manually run <b>make sidekiq</b> and <b>make start</b> and then check the website working on <a href="http://127.0.0.1:3000">localhost</a>.</p>
<p>Later you can log in to this site using your GitHub account. After that, your account will be created.</p>