const radarChart = () => {
  let ctx = document.getElementById('myChart')
  if (ctx) {
    ctx = ctx.getContext('2d');
    const options = {
      scale: {
          angleLines: {
              display: true
          },
          ticks: {
              suggestedMin: -1,
              suggestedMax: 5,
              stepSize: 1
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
};

export {radarChart};
