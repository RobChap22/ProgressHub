const dewIt = () => {
  const ctx = document.getElementById('myChart').getContext('2d');
  const options = {
    scale: {
        angleLines: {
            display: true
        },
        ticks: {
            suggestedMin: 0,
            suggestedMax: 10
        }
    }
  };
  fetch('./dashboard.json')
  .then(response => response.json())
  .then((data) => {
    console.log(data);
    const myRadarChart = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: options
    });
  });
};

export {dewIt};
