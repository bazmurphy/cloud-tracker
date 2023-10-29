import Header from "./components/Header";
import CourseworkList from "./components/CourseworkList";
import LoadBalancer from "./components/LoadBalancer";

function App() {
  return (
    <>
      <LoadBalancer />
      <Header />
      <main>
        <CourseworkList />
      </main>
    </>
  );
}

export default App;
